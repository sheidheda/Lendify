;; Liquidation Contract

(use-trait ft-trait .sip-010-trait.sip-010-trait)

(define-public (liquidate-loan (loan-id uint) (token <ft-trait>))
  (let
    (
      ;; Get the loan details from the loan-core contract
      (loan (unwrap! (contract-call? .loan-core get-loan loan-id) (err u404)))
      ;; Get the collateral information from the collateral-manager contract
      (collateral (unwrap! (contract-call? .collateral-manager get-collateral loan-id) (err u404)))
    )

    ;; Assert that the loan's due date has passed
    (asserts! (> block-height (get due-date loan)) (err u403))

    ;; Assert that the loan is still active
    (asserts! (get is-active loan) (err u403))

    ;; Transfer the collateral from the contract to the lender
    (try! (as-contract (contract-call? token transfer (get amount collateral) (as-contract tx-sender) (get lender loan))))

    ;; Close the loan in the loan-core contract
    (try! (contract-call? .loan-core close-loan loan-id))

    ;; Return success
    (ok true)
  )
)
