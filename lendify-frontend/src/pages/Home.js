import React from 'react';

function Home() {
    return (
        <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-blue-500 to-purple-500 text-white">
            <h1 className="text-4xl font-bold mb-4">Welcome to Lendify</h1>
            <p className="text-lg mb-6">Your decentralized lending platform.</p>
            <button 
                onClick={() => alert('Connect Wallet')} 
                className="px-6 py-2 bg-white text-blue-500 rounded-lg shadow-lg hover:bg-blue-100 transition duration-300"
            >
                Connect Wallet
            </button>
        </div>
    );
}

export default Home;
