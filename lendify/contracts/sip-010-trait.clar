;; sip-010 trait
(define-trait sip-010-trait
  (
    ;; Transfer tokens from one principal to another
    (transfer (uint principal principal) (response bool uint))

    ;; Get the name of the token
    (get-name () (response (string-ascii 32) uint))

    ;; Get the symbol of the token
    (get-symbol () (response (string-ascii 32) uint))

    ;; Get the number of decimals for the token
    (get-decimals () (response uint uint))

    ;; Get the balance of a principal
    (get-balance (principal) (response uint uint))

    ;; Get the total supply of the token
    (get-total-supply () (response uint uint))

    ;; Get the token URI (optional)
    (get-token-uri () (response (optional (string-utf8 256)) uint))
  )
)
