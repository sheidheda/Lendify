import React, { createContext, useContext, useState, useEffect } from 'react';
import { parseEther, formatEther, Wallet, getDefaultProvider } from 'ethers';

// Create context for wallet details
const WalletContext = createContext();

export const useWallet = () => useContext(WalletContext);

export function MockWalletProvider({ children }) {
    const [walletAddress, setWalletAddress] = useState(null);
    const [balance, setBalance] = useState(null);
    const [mockWallet, setMockWallet] = useState(null);
    const [provider, setProvider] = useState(null);

    useEffect(() => {
        // Initialize provider and mock wallet
        const initProviderAndWallet = async () => {
            const goerliProvider = getDefaultProvider('goerli');
            setProvider(goerliProvider);

            // Generate mock wallet
            const wallet = Wallet.createRandom();
            const connectedWallet = wallet.connect(goerliProvider);
            setMockWallet(connectedWallet);
            setWalletAddress(connectedWallet.address);
        };

        initProviderAndWallet();
    }, []);

    // Fetch balance
    useEffect(() => {
        const fetchBalance = async () => {
            if (mockWallet && provider) {
                const walletBalance = await provider.getBalance(mockWallet.address);
                setBalance(formatEther(walletBalance));
            }
        };
        fetchBalance();
    }, [mockWallet, provider]);

    // Send transaction function
    const sendTransaction = async () => {
        try {
            const tx = await mockWallet.sendTransaction({
                to: mockWallet.address,
                value: parseEther("0.001"),
            });
            await tx.wait();
            alert('Transaction complete!');
        } catch (error) {
            console.error('Transaction failed:', error);
        }
    };

    // Mock loan processing
    const requestLoan = async (loanAmount) => {
        try {
            // Simulate transaction delay
            await new Promise((resolve) => setTimeout(resolve, 2000)); // 2 seconds delay

            // Mock balance update
            const updatedBalance = parseFloat(balance) + parseFloat(loanAmount);
            setBalance(updatedBalance.toString());
            alert('Loan Approved!');
        } catch (error) {
            console.error('Loan request failed:', error);
        }
    };

    return (
        <WalletContext.Provider value={{ walletAddress, balance, sendTransaction, requestLoan }}>
            {children}
        </WalletContext.Provider>
    );
}
