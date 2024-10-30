import React from 'react';
import { useWallet } from '../components/MockWalletProvider';
import { useNavigate } from 'react-router-dom';

function Dashboard() {
    const { walletAddress, balance } = useWallet();
    const navigate = useNavigate();

    return (
        <div className="flex flex-col items-center justify-center p-10 text-center">
            <h1 className="text-4xl font-bold mb-8">Welcome, Mr. Faithful!</h1>
            <div className="bg-gray-800 p-8 rounded-lg shadow-lg w-full max-w-md">
                <h2 className="text-2xl font-semibold mb-4">Wallet Information</h2>
                {walletAddress && (
                    <>
                        <p className="text-sm font-semibold">Wallet Address:</p>
                        <p className="break-words text-xs mb-6">{walletAddress}</p>
                        <p className="text-sm font-semibold">Balance:</p>
                        <p className="text-lg font-bold mb-6">
                            {balance ? `${balance} ETH` : 'Loading...'}
                        </p>
                        <button
                            onClick={() => navigate('/loan')}
                            className="w-full px-4 py-2 mt-4 bg-blue-500 rounded hover:bg-blue-600 transition duration-300"
                        >
                            Request Loan
                        </button>
                    </>
                )}
            </div>
            <div className="mt-8">
                <p className="text-gray-400 animate-pulse">Powered by Clarity</p>
            </div>
        </div>
    );
}

export default Dashboard;
