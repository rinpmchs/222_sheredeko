  .text

binary_search:
  sub  a4, a3, a2
  srli a5, a4, 31
  add  a5, a5, a4
  srai a5, a5, 1
  add  a0, a5, a2
  ble  a2, a3, search_end

search_compare:
  slli a6, a0, 2
  add  a6, a6, a1
  lw   a6, 0(a6)
  beq  a6, a1, target_found
  bgt  a6, a1, search_loop

  addi a2, a0, 1
  j    search_compare

search_loop:
  addi a3, a0, -1
  j    binary_search

target_found:
  ret

search_end:
  li   a0, -1
  ret
