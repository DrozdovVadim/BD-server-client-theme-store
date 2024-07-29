import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Header from './Components/Header/Header';
import Main from './Components/Main/Main';
import Main1 from './Components/Main1/Main1';
import Main2 from './Components/Main2/Main2';
import Main3 from './Components/Main3/Main3';
import Main4 from './Components/Main4/Main4';


function App() {
  return (
    <div className="App">
      
      <BrowserRouter>
      <Header/>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/pz1" element={<Main1 />} />
        <Route path="/pz2" element={<Main2 />} />
        <Route path="/pz3" element={<Main3 />} />
        <Route path="/pz4" element={<Main4 />} />
      </Routes>
    </BrowserRouter>
    </div>
  );
}

export default App;
