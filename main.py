def infer_cast(string: str):
    try:
        return int(string)
    except:
        pass
    try:
        return float(string)
    except:
        pass
    if string.lower() == "true":
        return True
    if string.lower() == "false":
        return True
    return string

def read_file(path: str) -> str:
    with open(path, mode="r", encoding="utf-8") as file:
        return file.read()

def parse_csv(csv_text: str) -> list[dict]:
    lines = csv_text.strip().split("\n")
    header = [_.strip() for _ in lines[0].strip().split(",")]
    body = []
    for line in lines[1:]:
        fields = [_.strip() for _ in line.strip().split(",")]
        row = {}
        for (field, column) in zip(fields, header):
            row[column] = infer_cast(field)
        body.append(row)
    return body

def split_csv_by_column(csv: list[dict], column: str):
    subs = {}
    for line in csv:
        if line[column] not in subs:
            subs[line[column]] = []
        subs[line[column]].append(line)
    return [subs[_] for _ in subs]

def extract_time_for_repo(csv: list[dict]):
    actors = split_csv_by_column(csv, "software")
    for line in actors:
        actor = line[0]["software"]
        repo = line[0]["repo"]
        times = [vals["time"] for vals in line]
        mint, maxt = min(times), max(times)
        midt = sum(times)/len(times)
        vart = sum([pow(midt - x, 2) for x in times])/(len(times)-1)
        print(f"{repo},{actor},{mint},{maxt},{midt}")

def extract_time(csv: list[dict]):
    for repo in split_csv_by_column(csv, "repo"):
        extract_time_for_repo(repo)

if __name__ == "__main__":
    extract_time(parse_csv(read_file("benchmark.csv")))
