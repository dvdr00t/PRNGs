"""
MIDDLE-SQUARE METHOD

Implementation of the J. von Neumann middle-square algorithm for generating
pseudo-random numbers sequence.

@author Davide Arcolini
@email s256671@studenti.polito.it
@date 24/05/2021
"""


def is_even(n_digits) -> bool:
    """
    Check if the number is even or not
    :param n_digits:
    :return: Bool
    """
    if n_digits % 2 == 0:
        return True
    return False


# User is requested to insert a value with an even number of digits
seed_0 = int(input("Insert initial value (number of digits must be even): "))
n = len(str(seed_0))
while not is_even(n):
    print("[! Number of digits must be even !]")
    seed_0 = int(input("Insert initial value (number of digits must be even): "))
    n = len(str(seed_0))

sequence = set()  # Set of all numbers already in the sequence
end = int(n + n / 2)  # Starting digit for seed extraction
start = int(n - n / 2)  # Ending digit for seed extraction

number = seed_0
counter = 0
while number not in sequence:
    sequence.add(number)  # Adding number to the sequence
    counter = counter + 1

    # Seed extraction
    # .zfill() adds zeroes to the sequence
    number = int(str(number * number).zfill(2 * n)[start:end])
    print(f"#{counter}: {number}")

# Showing results
print(f"Starting with {seed_0}, repetition after {counter} steps.")
