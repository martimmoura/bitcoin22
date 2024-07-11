FILE = "data.log"

def count_addresses(file):
    count = {}
    with open(file, "r") as lines:
        for line in lines:
            #parse ip address from line
            ip = line.split(" ")[1]
            if ip in count:
                count[ip] += 1
            else:
                count[ip] = 1
    return count
    

def print_sorted_counts(count):
    for item in sorted(count.items(), key=lambda item: item[1], reverse=True):
        print(item[1], item[0])


print_sorted_counts(count_addresses(FILE))
