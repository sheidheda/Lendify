import React from 'react';
import { Link } from 'react-router-dom';

function Navbar() {
    return (
        <nav className="bg-white shadow-lg">
            <div className="max-w-6xl mx-auto px-4 py-2">
                <div className="flex justify-between items-center">
                    <h1 className="text-2xl font-bold text-blue-500">Lendify</h1>
                    <div>
                        <Link to="/" className="text-blue-500 hover:text-blue-700 px-4">
                            Home
                        </Link>
                        <Link to="/loan/1" className="text-blue-500 hover:text-blue-700 px-4">
                            Loan Details
                        </Link>
                    </div>
                </div>
            </div>
        </nav>
    );
}

export default Navbar;
