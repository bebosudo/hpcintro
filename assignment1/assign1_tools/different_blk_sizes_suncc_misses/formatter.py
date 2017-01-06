#!/usr/bin/env python2

# The expected input files have to be in this format:
# 100 lib    234.375   5312.893 # matmult_lib
# 0:01.51
# 500 lib   5859.375   5252.895 # matmult_lib
# 0:00.95
# 1000 lib  23437.500   5316.420 # matmult_lib
# 0:01.51
#
# Output file:
# 100 lib    234.375   5312.893  0:01.51
# 500 lib   5859.375   5252.895  0:00.95
# 1000 lib  23437.500   5316.420 0:01.51


def formatter(filein, fileout):
    with open(filein, "r") as fi:
        with open(fileout, "w") as fo:
            for index, line in enumerate(fi):
                line = line.strip()
                if index % 2 == 0:
                    # example odd line:
                    '''5000 lib 585937.500   5249.591 # matmult_lib'''

                    # Remove all the characters after the '#'
                    columns = line.split()
                    hashtag_pos = columns.index("#")
                    fo.write(' '.join(columns[:hashtag_pos]))
                else:
                    # Example even line:
                    # 0:01.51
                    line = "  "+line+"\n"
                    fo.write(line)


def splitter(filein):
    # Divide the whole file in different files, in order to plot them later.

    with open(filein, "r") as fi:
        for line in fi:
            s = line.strip().split()
            # Grab the type of data from the second column of the input file.
            comb = s[1]

            # Make sure that the folder plot/ exists!
            fileout = "plot/"+filein+".blksize-"+comb+".txt"
            # Open the output file to append at its end.
            with open(fileout, "a") as fo:
                # fo.write(s[0]+" " + " ".join(s[2:]) + "\n")
                fo.write(" ".join(s[2:4]) + "\n")


if __name__ == "__main__":
    import sys
    try:
        filein = sys.argv[1]
    except IndexError:
        print "  Insert the file to clean as the first parameter after this script."
        raise SystemExit

    intermediate_file = filein + ".clean"
    formatter(filein, intermediate_file)

    # if len(sys.argv) == 3 and sys.argv[2] == "perm":
    splitter(intermediate_file)