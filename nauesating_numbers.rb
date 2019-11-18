#Part One
def strange_sums(array)
    array.select { |num|
        array.any? { |opp| num + opp == 0 }
    }.length/2
end
p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0



def pair_product(arr, num)
    arr.each_with_index.any? { |i, idx|
        arr.each_with_index.any? { |n, idx2| n * i == num && idx != idx2 }
    }
end
p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false



def rampant_repeats(str, hash)
    str.chars.map { |c| hash.keys.include?(c) ? c * hash[c] : c}.join("")
end
p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'



def perfect_square(num)
    (1..num).any? { |i| i*i == num }
end
p perfect_square(1)     # true
p perfect_square(4)     # true
p perfect_square(64)    # true
p perfect_square(100)   # true
p perfect_square(169)   # true
p perfect_square(2)     # false
p perfect_square(40)    # false
p perfect_square(32)    # false
p perfect_square(50)    # false



#Part Two
def anti_prime?(num)
    (1..num).none? { |i| full_factorization(i).length > full_factorization(num).length }
end

def full_factorization(num)
    (1..num).select { |i| num % i == 0 }
end
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false



def matrix_addition(matrix_1, matrix_2)
    matrix_1.each_with_index.map { |row, idx| 
        row.each_with_index.map { |ele, idx2|
            ele + matrix_2[idx][idx2]
        }
    }
end
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]
p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*nums)
    mutuals = []
    nums.each { |num| mutuals << full_factorization(num) }
    mutuals.reduce(:|).select { |i| nums.all? { |i2| i2 % i == 0 } }
end
p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]

def tribonacci_number(num)
    tribonaccis = [1, 1, 2]
    if num <= 3
        tribonaccis[num-1]
    else
        tribonaccis << tribonaccis[-1]+tribonaccis[-2]+tribonaccis[-3] until tribonaccis.length == num
        tribonaccis[-1]
    end
end
p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274



#Part Three
def matrix_addition_reloaded(*matrices)
    unless matrices.all? { |m| m.length == matrices[0].length }
        nil
    else
        matrices.reduce { |added, m| matrix_addition(added, m) }
    end
end
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]
p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil



def squarocol?(arr)
    arr.any? { |subarr| subarr.uniq.length == 1 } || arr.transpose.any? { |subarr| subarr.uniq.length == 1 }
end
p squarocol?([
   [:a, :x , :d],
   [:b, :x , :e],
   [:c, :x , :f],
]) # true

p squarocol?([
   [:x, :y, :x],
   [:x, :z, :x],
   [:o, :o, :o],
]) # true

p squarocol?([
   [:o, :x , :o],
   [:x, :o , :x],
   [:o, :x , :o],
]) # false

p squarocol?([
   [1, 2, 2, 7],
   [1, 6, 6, 7],
   [0, 5, 2, 7],
   [4, 2, 9, 7],
]) # true

p squarocol?([
   [1, 2, 2, 7],
   [1, 6, 6, 0],
   [0, 5, 2, 7],
   [4, 2, 9, 7],
]) # false


def squaragonal?(arr)
    arr.each_with_index.collect { |subarr, i| subarr[i] }.uniq.length == 1 ||
    arr.each_with_index.collect { |subarr, i| subarr[arr.length-i-1] }.uniq.length == 1 
end

p squaragonal?([
   [:x, :y, :o],
   [:x, :x, :x],
   [:o, :o, :x],
]) # true

p squaragonal?([
   [:x, :y, :o],
   [:x, :o, :x],
   [:o, :o, :x],
]) # true

p squaragonal?([
   [1, 2, 2, 7],
   [1, 1, 6, 7],
   [0, 5, 1, 7],
   [4, 2, 9, 1],
]) # true

p squaragonal?([
   [1, 2, 2, 5],
   [1, 6, 5, 0],
   [0, 2, 2, 7],
   [5, 2, 9, 7],
]) # false


def pascals_triangle(num)
    if num < 1
        nil
    else
        triangle = [[1]]
        until triangle.length == num
            triangle << Array.new(triangle[-1].length+1) { |i| 
                case i
                when 0
                    1
                when triangle[-1].length+1
                    1
                else
                    (triangle[-1][i] || 0) + triangle[-1][i-1] 
                end
            }
        end
        triangle
    end
end

p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]


#Part Four

def mersenne_prime(num)
    
    mersennes = []
    exponents_attempted = []

    until mersennes.length == num
        exponent = exponents_attempted[-1] ? exponents_attempted[-1] + 1 : 2
        p = (2 ** exponent) - 1
        exponents_attempted << exponent

        until prime?(p)
            exponent = exponents_attempted[-1] + 1
            p = (2 ** exponent) - 1
            exponents_attempted << exponent
        end
        mersennes << p
    end
    mersennes[-1]
end
def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    
    return true
end

p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071

#triangular number is:  (n * n+1) / 2, n > 0
def triangular_word?(str)
    encoding = 0
    str.each_codepoint { |c| encoding += c % 96 }

    triangular_numbers = Hash.new { |h,k| h[k] = ((k * (k+1)) / 2)}

    i = 1
    until triangular_numbers[i] >= encoding
        i += 1
    end
    
    triangular_numbers[i] == encoding
end

p triangular_word?('a')         # true
p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false


def consecutive_collapse(arr)
    #cons will either be nil if we have no adjacent consecutives, or the index of the first adjacent if we find a pair
    cons = arr.each_with_index.reduce(nil) { |acc, (ele, idx)| 
        acc ? acc : (
            (arr[idx+1] && (ele == (arr[idx+1] + 1) || ele == (arr[idx+1] - 1))) ? idx : acc
        ) 
    }
    
    if cons
        arr.slice!(cons..cons+1)
        consecutive_collapse(arr)
    else
        arr
    end
end
p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []


def primes_up_to(num)
    return [] if num < 2
    primes = [2]
    i = 3

    while primes[-1] < num
        if is_prime?(i, primes)
            primes << i
        end
        i += 1
    end

    primes.pop if primes[-1] > num

    primes
end

def is_prime?(num, primes)
    return false if num < 2

    primes.each do |factor|
        if num % factor == 0
            return false
        end
    end
    
    return true
end

def pretentious_primes(arr, num)
    real_primes = primes_up_to(arr.max * 2)
    
    arr.map { |ele| 
        idx = 0
        idx += 1 until real_primes[idx] >= ele

        if num > 0
            ele == real_primes[idx] ? real_primes[num+idx] : real_primes[num+idx-1]
        else
            (idx+num < 0) ? nil : real_primes[idx+num]
        end
    }
end
p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]

