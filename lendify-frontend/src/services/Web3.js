import React from 'react';
import { useWallet } from '../components/MockWalletProvider';

export function WalletInfoComponent() {
    const { walletAddress, balance, sendTransaction } = useWallet();

    // Fetch wallet information
    const getWalletInfo = () => {
        return { walletAddress, balance };
    };

    // Trigger a mock transaction
    const makeMockTransaction = async () => {
        try {
            await sendTransaction();
        } catch (error) {
            console.error("Transaction failed:", error);
        }
    };

    return (
        <div>
            <h2>Wallet Information</h2>
            <p>Address: {walletAddress}</p>
            <p>Balance: {balance}</p>
            <button onClick={makeMockTransaction}>Send Transaction</button>
        </div>
    );
}
