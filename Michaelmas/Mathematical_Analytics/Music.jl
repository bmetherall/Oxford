using DelimitedFiles

function ReadLyrics(fname)
    A = ["", "", "", "", "", "", "", "", "", ""]
    println(A[2])
    for i in 0:9
        f = open(join([fname, string(i), ".txt"]), "r");
        A[i+1] = read(f, String)
    end
    return A
end

function NumVowels(A)
    v = "aeiou"
    num = zeros(length(A))
    for i in 1:length(A)
        num[i] = count(c -> (c in v), lowercase(A[i]))
    end
    return num
end

function NumPunc(A)
    punc = ".,'/!?-"
    num = zeros(length(A))
    for i in 1:length(A)
        num[i] = count(c -> (c in punc), lowercase(A[i]))
    end
    return num
end

mika = ReadLyrics("./Desktop/Oxford/Courses/Mathematical_Analytics/mika")
mcfly = ReadLyrics("./Desktop/Oxford/Courses/Mathematical_Analytics/mcfly")


ma = maximum((NumVowels(mika), NumVowels(mcfly)))
mb = maximum((NumPunc(mika), NumPunc(mcfly)))

f = open("Mika.dat", "w")
writedlm(f, hcat(NumVowels(mika) ./ ma, NumPunc(mika) ./ ma)
close(f)

f = open("McFly.dat", "w")
writedlm(f, hcat(NumVowels(mcfly) ./ mb, NumPunc(mcfly) ./ mb))
close(f)
