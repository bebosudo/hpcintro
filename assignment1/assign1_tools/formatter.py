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


if __name__ == "__main__":
    import sys
    try:
        filein = sys.argv[1]
    except IndexError:
        print "Insert the file to clean as the first parameter after this script."
        raise SystemExit

    fileout = filein + ".clean"
    formatter(filein, fileout)
