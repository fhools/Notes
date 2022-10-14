# Program Address
Program address are account keys that the program has authority to sign for,
they are not on the Ed25519 curve, and thus have no private key.
See invoke_signed(). Solana runtime will check the program associated with address
is caller and authorized to sign.

create_program_address(), may generate an invalid, use find_program_address(),
to caclulate bump seed in that case.
