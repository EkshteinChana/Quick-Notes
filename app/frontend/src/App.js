import React, { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [notes, setNotes] = useState([]);
  const [titleInput, setTitleInput] = useState('');
  const [contentInput, setContentInput] = useState('');

  const API_URL = process.env.REACT_APP_API_URL;

  useEffect(() => {
    fetch(`${API_URL}/notes`)
      .then(response => response.json())
      .then(data => setNotes(data))
      .catch(error => console.error('Error fetching notes:', error));
  }, [API_URL]);

  const addNote = async () => {
    if (!titleInput.trim() || !contentInput.trim()) return;
    
    console.log(`process.env.REACT_APP_API_URL:${process.env.REACT_APP_API_URL}`);
    const response = await fetch(`${API_URL}/notes`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title: titleInput, content: contentInput }),
    });

    if (response.ok) {
      // After successful creation, fetch all notes again
      const updatedNotes = await fetch(`${API_URL}/notes`).then(res => res.json());
      setNotes(updatedNotes);
      setTitleInput('');
      setContentInput('');
    } else {
      console.error('Failed to add note');
      console.log(`process.env.REACT_APP_API_URL:${process.env.REACT_APP_API_URL}`);
    }
  };

  const deleteNote = async (id) => {
    const response = await fetch(`${API_URL}/notes/${id}`, {
      method: 'DELETE',
    });

    if (response.ok) {
      setNotes(prev => prev.filter(note => note.id !== id));
    } else {
      console.error('Failed to delete note');
    }
  };

  return (
    <div className="App">
      <h1>Quick Notes</h1>
      <div className="note-input">
        <input
            type="text"
            placeholder="Note title..."
            value={titleInput}
            onChange={(e) => setTitleInput(e.target.value)}
        />
        <textarea
            placeholder="Note content..."
            value={contentInput}
            onChange={(e) => setContentInput(e.target.value)}
        />
        <button onClick={addNote}>Add Note</button>
     </div>
      <ul className="note-list">
        {notes.map(note => (
          <li key={note.id}>
            <strong>{note.title}</strong><br />
            {note.content}
            <br />
            <button onClick={() => deleteNote(note.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
