file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

card_dict = Dict('2' => 0, '3' => 1, '4' => 2, '5' => 3, '6' => 4, '7' => 5, '8' => 6, 
                 '9' => 7, 'T' => 8, 'J' => -1, 'Q' => 10, 'K' => 11, 'A' => 12)

fives = [x^5 for x in keys(card_dict)]
fours = [x^4 for x in keys(card_dict)]
full_houses = vcat([x^3*y^2 for x in keys(card_dict), y in keys(card_dict) if x !=y ], 
                   [x^2*y^3 for x in keys(card_dict), y in keys(card_dict) if x !=y ])
triples = [x^3 for x in keys(card_dict)]
two_pairs = [x^2*y^2 for x in keys(card_dict), y in keys(card_dict) if x !=y ]
one_pairs = [x^2 for x in keys(card_dict)]


function card_less_than(char1, char2)
    return card_dict[char1] < card_dict[char2]
end

function getStrength(hand)
    sortedHand = join(sort(collect(hand), lt=card_less_than))
    if sortedHand in fives
        return 5
    end
    for four in fours
        if findfirst(four, sortedHand) !== nothing
            return 4
        end
    end
    for full_house in full_houses
        if findfirst(full_house, sortedHand) !== nothing
            return 3
        end
    end
    for triple in triples
        if findfirst(triple, sortedHand) !== nothing
            return 2
        end
    end
    for two_pair in two_pairs
        if findfirst(two_pair[1:2], sortedHand) !== nothing && findfirst(two_pair[3:4], sortedHand) !== nothing
            return 1
        end
    end
    for one_pair in one_pairs
        if findfirst(one_pair, sortedHand) !== nothing
            return 0
        end
    end
    return -1 
end

function hand_less_than(x, y)
    hand1 = split(x, ' ')[1]
    hand2 = split(y, ' ')[1]
    s1 = getStrength(hand1)
    s2 = getStrength(hand2)
    if s1 == s2 
        for i in 1:length(hand1)
            if hand1[i] == hand2[i]
                continue
            end
            return card_dict[hand1[i]] < card_dict[hand2[i]]
        end
    end
    return s1 < s2
end

function hand_less_than2(x, y)
    hand1 = split(x, ' ')[1]
    hand2 = split(y, ' ')[1]
    s1 = findmax([getStrength(replace(hand1, "J" => x)) for x in keys(card_dict)])[1]
    s2 = findmax([getStrength(replace(hand2, "J" => x)) for x in keys(card_dict)])[1]
    if s1 == s2 
        for i in 1:length(hand1)
            if hand1[i] == hand2[i]
                continue
            end
            return card_dict[hand1[i]] < card_dict[hand2[i]]
        end
    end
    return s1 < s2
end

function task1()
    sum = 0
    bets = map((x) -> parse(Int, split(x, ' ')[2]) ,sort(line_array, lt=hand_less_than))
    for i in 1:length(bets)
        sum += i*bets[i]
    end
    println(sum)
end

function task2()
    sum = 0
    bets = map((x) -> parse(Int, split(x, ' ')[2]) ,sort(line_array, lt=hand_less_than2))
    for i in 1:length(bets)
        sum += i*bets[i]
    end
    println(sum)
end
task1()
task2()
