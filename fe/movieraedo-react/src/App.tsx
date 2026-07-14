import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './layout/Home';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/home">
          <Route index element={<Home />}></Route>
          <Route path="introduce" element={<h1>introduce</h1>} />
          <Route path="news" element={<h1>news</h1>} />
          <Route path="contact" element={<h1>contact</h1>} />
          <Route path="movie" element={<h1>Movie</h1>}></Route>
        </Route>  
        
        <Route path='/admin' element={<h1>Admin</h1>} />
        <Route path='/supper-admin' element={<h1>Supper Admin</h1>} />
      </Routes>
    </Router>
  );
}

export default App;
