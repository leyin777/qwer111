import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Login from './Login';
import Login2 from './Login2';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/Login2" element={<Login2 />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;