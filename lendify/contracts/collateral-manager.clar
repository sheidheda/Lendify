(use-trait ft-trait .sip-010-trait.sip-010-trait)

(define-map collaterals
  { loan-id: uint }  ;; The key is the loan ID
  { amount: uint, token: principal }  ;; The collateral amount and token address
)

(define-public (deposit-collateral (loan-id uint) (amount uint) (token <ft-trait>))
  (let
    (
      (loan (unwrap! (contract-call? .loan-core get-loan loan-id) (err u404)))
    )
    ;; Make sure the borrower is the tx-sender
    (asserts! (is-eq (get borrower loan) tx-sender) (err u403))
    ;; Transfer the collateral amount from the borrower to the contract
    (try! (contract-call? token transfer amount tx-sender (as-contract tx-sender)))
    ;; Store the collateral details in the map
    (map-set collaterals
      { loan-id: loan-id }
      { amount: amount, token: (contract-of token) }
    )
    (ok true)
  )
)

(define-public (withdraw-collateral (loan-id uint) (token <ft-trait>))
  (let
    (
      (loan (unwrap! (contract-call? .loan-core get-loan loan-id) (err u404)))
      (collateral (unwrap! (map-get? collaterals { loan-id: loan-id }) (err u404)))
    )
    ;; Ensure the borrower is the one withdrawing and the loan is inactive
    (asserts! (is-eq (get borrower loan) tx-sender) (err u403))
    (asserts! (not (get is-active loan)) (err u403))
    ;; Transfer the collateral back to the borrower
    (try! (as-contract (contract-call? token transfer (get amount collateral) (as-contract tx-sender) tx-sender)))
    ;; Remove the collateral record from the map
    (map-delete collaterals { loan-id: loan-id })
    (ok true)
  )
)

;; Read-only function to get collateral information for a loan
(define-read-only (get-collateral (loan-id uint))
  (map-get? collaterals { loan-id: loan-id })
)
