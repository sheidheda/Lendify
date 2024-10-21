(use-trait ft-trait .sip-010-trait.sip-010-trait)

(define-map loans
  { id: uint }
  {
    borrower: principal,
    lender: principal,
    amount: uint,
    collateral: uint,
    interest-rate: uint,
    due-date: uint,
    is-active: bool
  }
)

(define-data-var next-loan-id uint u0)

(define-public (create-loan 
    (lender principal)
    (amount uint)
    (collateral uint)
    (interest-rate uint)
    (duration uint)
    (token <ft-trait>))
  (let
    ((loan-id (var-get next-loan-id))
     (due-date (+ block-height duration)))
    (try! (contract-call? token transfer amount tx-sender (as-contract tx-sender)))
    (try! (contract-call? token transfer collateral tx-sender (as-contract tx-sender)))
    (map-set loans
      { id: loan-id }
      {
        borrower: tx-sender,
        lender: lender,
        amount: amount,
        collateral: collateral,
        interest-rate: interest-rate,
        due-date: due-date,
        is-active: true
      }
    )
    (var-set next-loan-id (+ loan-id u1))
    (ok loan-id)
  )
)

(define-read-only (get-loan (loan-id uint))
  (map-get? loans { id: loan-id })
)

(define-public (close-loan (loan-id uint))
  (let ((loan (unwrap! (get-loan loan-id) (err u404))))
    (asserts! (is-eq tx-sender (get lender loan)) (err u403))
    (asserts! (get is-active loan) (err u403))
    (map-set loans
      { id: loan-id }
      (merge loan { is-active: false })
    )
    (ok true)
  )
)