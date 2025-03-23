import datetime

def weeknum(year, month, day, isZeroPadding = False):
    date = datetime.datetime(year, month, day)
    result = str(date.isocalendar()[1])
    if isZeroPadding:
        result = result.zfill(2)
    return result

def main():
    print(weeknum(2025, 2, 23, True))

if __name__ == '__main__':
    # main()
    pass
