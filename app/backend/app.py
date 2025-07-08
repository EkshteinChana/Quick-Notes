from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import os
import logging


DB_HOST = os.environ.get('DB_HOST', 'localhost')
DB_PORT = int(os.environ.get('DB_PORT', 3306))
DB_USER = os.environ.get('DB_USER', 'root')
DB_PASSWORD = os.environ.get('DB_PASSWORD', 'root')
DB_NAME = os.environ.get('DB_NAME', 'notes')
GUI_URL= os.environ.get('GUI_URL', 'http://localhost')


def get_db_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )


app = Flask(__name__)
CORS(app, origins=[GUI_URL])

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@app.route('/notes', methods=['GET'])
def get_notes():
    logger.info("Received GET request at /notes")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM notes')
    notes = cursor.fetchall()
    logger.info(f"Returning {len(notes)} notes")
    cursor.close()
    conn.close()
    return jsonify(notes)

@app.route('/notes', methods=['POST'])
def create_note():
    data = request.get_json()
    logger.info(f"Received POST at /notes with payload: {data}")
    title = data.get('title')
    content = data.get('content')

    if not title or not content:
        logger.warning("POST /notes missing title or content")
        return jsonify({'error': 'Title and content are required'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('INSERT INTO notes (title, content) VALUES (%s, %s)', (title, content))
    conn.commit()
    logger.info("Note inserted into database")
    cursor.close()
    conn.close()

    return jsonify({'message': 'Note created successfully'}), 201



@app.route('/notes/<int:note_id>', methods=['DELETE'])
def delete_note(note_id):
    logger.info(f"Received DELETE request for note ID: {note_id}")
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM notes WHERE id = %s', (note_id,))
    note = cursor.fetchone()

    if note is None:
        logger.warning(f"Note ID {note_id} not found")
        cursor.close()
        conn.close()
        return jsonify({'error': 'Note not found'}), 404

    cursor.execute('DELETE FROM notes WHERE id = %s', (note_id,))
    conn.commit()
    logger.info(f"Note ID {note_id} deleted")
    cursor.close()
    conn.close()

    return jsonify({'message': 'Note deleted successfully'})


@app.errorhandler(Exception)
def handle_exception(e):
    logger.exception("Unhandled exception:")
    return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

