import React, { useEffect, useState } from 'react';
import { useWallet } from '../components/MockWalletProvider';

function LoanPage() {
    const { walletAddress, balance, requestLoan } = useWallet();
    const [loanAmount, setLoanAmount] = useState('');
    const [loanStatus, setLoanStatus] = useState(null);
    const [loading, setLoading] = useState(false);

    const handleLoanRequest = async () => {
        setLoading(true);
        setLoanStatus("Processing Loan...");

        try {
            await requestLoan(loanAmount); // Call the new requestLoan function
            setLoanStatus("Loan Requested Successfully!");
        } catch (error) {
            console.error("Loan Request Failed:", error);
            setLoanStatus("Transaction Failed");
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="p-10 text-center bg-gray-900 text-white min-h-screen bg-gradient-to-r">
            <h1 className="text-3xl font-bold mb-8">Loan Page</h1>
            <div className="bg-gray-800 p-6 rounded-lg shadow-md max-w-md mx-auto">
                <h2 className="text-xl font-semibold mb-4">Request a Loan</h2>
                <div className="text-sm mb-4">
                    <p><strong>Wallet Address:</strong> {walletAddress}</p>
                    <p><strong>Balance:</strong> {balance ? `${balance} ETH` : 'Loading...'}</p>
                </div>
                <input
                    type="number"
                    placeholder="Enter Loan Amount"
                    value={loanAmount}
                    onChange={(e) => setLoanAmount(e.target.value)}
                    className="p-2 mb-4 w-full rounded text-gray-900"
                />
                <button
                    onClick={handleLoanRequest}
                    className="w-full px-4 py-2 bg-indigo-600 rounded hover:bg-indigo-700 transition duration-300"
                    disabled={loading}
                >
                    {loading ? "Processing..." : "Request Loan"}
                </button>
                {loanStatus && (
                    <p className="mt-4 text-sm">{loanStatus}</p>
                )}
            </div>
            <div className="mt-8">
                <p className="text-gray-400 animate-pulse">Powered by Clarity</p>
            </div>
        </div>
    );
}

export default LoanPage;
