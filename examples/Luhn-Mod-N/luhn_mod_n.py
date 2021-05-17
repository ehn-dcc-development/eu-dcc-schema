"""
    Luhn-Mod-N Reference Implementation in Python
    Based on: https://en.wikipedia.org/wiki/Luhn_mod_N_algorithm
    Usage:
    LuhnModN.generate_check_character("URN:UVCI:01:NL:MY/INPUT/STRING")  # S
    LuhnModN.validate_check_character("URN:UVCI:01:NL:MY/INPUT/STRINGS") # True
"""


class LuhnModN:
    _CODE_POINTS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/:"

    @classmethod
    def _number_of_valid_input_characters(cls):
        return len(cls._CODE_POINTS)

    @classmethod
    def _code_point_from_character(cls, character: str) -> int:
        return cls._CODE_POINTS.index(character)

    @classmethod
    def _character_from_code_point(cls, code_point: int) -> str:
        return cls._CODE_POINTS[code_point]

    @classmethod
    def _luhn_mod_n(cls, factor, txt):
        total = 0
        n = cls._number_of_valid_input_characters()
        # Starting from the right, work leftwards
        # Now, the initial "factor" will always be "1"
        # since the last character is the check character.
        for i in range(len(txt) - 1, -1, -1):
            code_point = cls._code_point_from_character(txt[i])
            addend = factor * code_point

            # Alternate the "factor" that each "code_point" is multiplied by
            factor = 1 if (factor == 2) else 2

            # Sum the digits of the "addend" as expressed in base "n"
            addend = (addend // n) + (addend % n)
            total += addend
        remainder = total % n
        return remainder

    @classmethod
    def generate_check_character(cls, txt: str) -> str:
        factor = 2
        remainder = cls._luhn_mod_n(factor, txt)
        n = cls._number_of_valid_input_characters()
        check_code_point = (n - remainder) % n
        return cls._character_from_code_point(check_code_point)

    @classmethod
    def validate_check_character(cls, txt: str) -> bool:
        factor = 1
        remainder = cls._luhn_mod_n(factor, txt)
        return remainder == 0
