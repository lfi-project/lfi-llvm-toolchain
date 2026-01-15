// This file holds boxrt callback routines that are separately loaded. The
// assembly in this file is not meant to pass through the rewriter but will
// still be loaded into the sandbox. The important part of this file is the
// large amount of callback slots, allowing the LFI runtime to register many
// callbacks for library sandboxing. We provide them in this file rather than
// dynamically creating them in the sandbox for systems like Android that have
// restrictions regarding marking executable pages: we can only mark pages as
// executable if they are loaded from a file. Since the file is separately
// loaded the code can be shared across multiple sandboxes.

.text

.no_expand

#define LFI_CALLBACKS 4096

#if defined(__aarch64__)
.p2align 16
.global _lfi_cb_code
_lfi_cb_code:
.set i, 0
.rept LFI_CALLBACKS
    bti jc
    ldr x16, .lfi_cb_data+(16*i)
    ldr x28, .lfi_cb_data+(16*i)+8
    blr x28
    .set i, i+1
.endr
.global _lfi_cb_code_end
_lfi_cb_code_end:

.global _lfi_cb_data
_lfi_cb_data:
.lfi_cb_data:
#elif defined(__x86_64__)
.p2align 12
.global _lfi_cb_code
_lfi_cb_code:
.set i, 0
.rept LFI_CALLBACKS
    .p2align 5
    endbr64
    movq .lfi_cb_data+(16*i)(%rip), %r10
    jmpq *.lfi_cb_data+(16*i)+8(%rip)
    .set i, i+1
.endr
.global _lfi_cb_code_end
_lfi_cb_code_end:

.p2align 12
.global _lfi_cb_data
_lfi_cb_data:
.lfi_cb_data:
#else
#error "invalid architecture"
#endif
