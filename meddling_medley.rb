#Phase 1: Modest Problems
#the instructions don't make sense as given:
#"return the count of the number of times the same character appears consecutively in the given string"
#if that means the number of characters which appear consecutively, then the answer for "hooray" is wrong
#otherwise if it means the number of times which a single character appeared, specifically the longest consecutive string, 
#   then the answer for "bootcamp" is wrong
#the rest of the examples are agnostic with respect to this difference
def duos(str)
end
# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0


def sentence_swap(sentence, hash)
    sentence.split(" ").map { |word| 
        hash.keys.include?(word) ? hash[word] : word
    }.join(" ")
end
# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'


def hash_mapped(hash, proc, &block)
    hash.map { |k, v| [block.call(k), proc.call(v)] }.to_h
end
# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}


def counted_characters(str)
    str.chars.select { |c| str.count(c) > 2 }.uniq
end
# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []


def triplet_true(str)
    str.each_char.with_index.any? { |c, i| c == str[i-1] && c == str[i+1] }
end
# p triplet_true('caaabb')        # true
# p triplet_true('terrrrrible')   # true
# p triplet_true('runninggg')     # true
# p triplet_true('bootcamp')      # false
# p triplet_true('e')             # false


def energetic_encoding(str, hash)
    str.chars.map { |c| (hash.keys.include?(c) || c == " ") ? (hash[c] || " ") : "?" }.join("")
end
# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'


def uncompress(str)
    string = ""
    str.each_char.with_index { |c, i| 
        i.even? ? string += c * str[i+1].to_i : nil
    }
    string
end
# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

#Phase 2: More difficult, maybe?
def conjunct_select(arr, *procs)
    arr.select { |ele| procs.all? { |proc| proc.call(ele) } }
end
# is_positive = Proc.new { |n| n > 0 }
# is_odd = Proc.new { |n| n.odd? }
# less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]


def convert_pig_latin(str)
    str.split(" ").map { |word| 
        new_word = word.length < 3 ? word : (/[aeiou]/.match?(word[0]) ? word + "yay" : word[word.index(/[aeiou]/)..-1] + word[0...word.index(/[aeiou]/)] + "ay" )
        (word == word.capitalize) ? new_word.capitalize : new_word
    }.join(" ")
end
# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"


def reverberate(str)
    str.split(" ").map { |word|
        new_word = word.length < 3 ? word : (/[aeiou]/.match?(word[-1]) ? word + word : word + word[word.rindex(/[aeiou]/)..-1])
        (word == word.capitalize) ? new_word.capitalize : new_word
    }.join(" ")
end
# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"


def disjunct_select(arr, *procs)
    arr.select { |ele| procs.any? { |proc| proc.call(ele) } }
end
# longer_four = Proc.new { |s| s.length > 4 }
# contains_o = Proc.new { |s| s.include?('o') }
# starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]


def alternating_vowel(str)
    str.split(" ").each_with_index.map { |word, idx| 
        if /[aeiou]/.match?(word)
            if idx.even? 
                word.slice!(word.index(/[aeiou]/))
                word
            else
                word.slice!(word.rindex(/[aeiou]/))
                word
            end
        else
            word
        end
    }.join(" ")
end
# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"


def silly_talk(str)
    str.split(" ").map { |word| 
        /[aeiou]/.match?(word[-1]) ? word + word[-1] : word.gsub(/[aeiou]/) { |match| match + "b" + match }
    }.join(" ")
end
# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"


def compress(str)
    compressed = ""
    str.each_char.with_index.reduce(str[0]+"0") { |acc, (c, idx)|
        if c == acc[0]
            compressed += (c + (acc[1..-1].to_i + 1).to_s) if idx == (str.length - 1)
            c + (acc[1..-1].to_i + 1).to_s
        else
            compressed += acc[1..-1].to_i > 1 ? acc : acc[0]
            compressed += c if idx == (str.length - 1)
            c + "1" 
        end

    }
    compressed
end
# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"
