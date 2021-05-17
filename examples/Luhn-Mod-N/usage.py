from luhn_mod_n import LuhnModN

txt = "URN:UVCI:01:NL:187/37512422923"
check = LuhnModN.generate_check_character(txt=txt)
is_valid = LuhnModN.validate_check_character(txt=(txt + check))
print(f"txt '{txt}' gives check character: {check}")
print(f"txt '{txt + check}' validates as: {is_valid}")
