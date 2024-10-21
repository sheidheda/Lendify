;; Lendify Token (LFY)

(impl-trait .sip-010-trait.sip-010-trait)

(define-fungible-token lendify-token)

(define-data-var token-uri (optional (string-utf8 256)) none)
(define-data-var contract-owner principal tx-sender)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u4))
    (asserts! (> (ft-get-balance lendify-token sender) amount) (err u5))
    (ft-transfer? lendify-token amount sender recipient)
  )
)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u403))
    (ft-mint? lendify-token amount recipient)
  )
)

(define-read-only (get-name)
  (ok "Lendify Token")
)

(define-read-only (get-symbol)
  (ok "LFY")
)

(define-read-only (get-decimals)
  (ok u6)
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance lendify-token account))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply lendify-token))
)

(define-read-only (get-token-uri)
  (ok (var-get token-uri))
)

(define-public (set-token-uri (new-uri (optional (string-utf8 256))))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u403))
    (var-set token-uri new-uri)
    (ok true)
  )
)

(define-public (set-contract-owner (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u403))
    (var-set contract-owner new-owner)
    (ok true)
  )
)