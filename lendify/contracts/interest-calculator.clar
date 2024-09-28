(define-read-only (calculate-interest (principal uint) (rate uint) (time uint))
  (let
    ((interest (/ (* (* principal rate) time) u10000)))
    (ok interest)
  )
)

(define-read-only (get-total-repayment (principal uint) (rate uint) (time uint))
  (let
    ((interest (unwrap-panic (calculate-interest principal rate time))))
    (ok (+ principal interest))
  )
)