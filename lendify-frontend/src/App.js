import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import { MockWalletProvider } from './components/MockWalletProvider';
import Dashboard from './pages/Dashboard';
import LoanPage from './pages/LoanPage';
import Header from './components/Header';


function App() {
    return (
        <MockWalletProvider>
            <Router>
                
                <div className="min-h-screen bg-gradient-to-r from-blue-900 via-indigo-900 to-purple-900 text-white font-sans">
                <Header />
                    <nav className="flex justify-center py-4 space-x-4">
                        <Link to="/" className="text-lg font-bold text-indigo-300 hover:text-indigo-500">Dashboard</Link>
                        <Link to="/loan" className="text-lg  font-bold text-indigo-300 hover:text-indigo-500">Loan Page</Link>
                    </nav>
                    <Routes>
                        <Route path="/" element={<Dashboard />} />
                        <Route path="/loan" element={<LoanPage />} />
                    </Routes>
                </div>
            </Router>
        </MockWalletProvider>
    );
}

export default App;
