import { useState } from 'react'
import { 
  BrowserRouter as Router, 
  Routes, 
  Route, 
  Navigate 
} from "react-router-dom";
import HomePage from './Pages/Home/Home.jsx';
import Patients from './Pages/Patients/Patients.jsx';
import Products from './Pages/Products/Products.jsx';
import Config from './Pages/Config/Config.jsx';

const AppRoutes = () =>{
  return(
    <Routes>
      <Route path='/' element={<HomePage/>}/>
      <Route path='/Patients' element={<Patients/>}/>
      <Route path='/Products' element={<Products/>}/>
      <Route path='/Config' element={<Config/>}/>

      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
    
  );
};

function App() {
  return (
    <Router>
        <AppRoutes />
    </Router>
  )
}

export default App
