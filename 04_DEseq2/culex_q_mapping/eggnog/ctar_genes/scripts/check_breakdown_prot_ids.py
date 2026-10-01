#!/usr/bin/env python3
m2g = dict(l.split() for l in open("mrna2gene.tsv"))

seqs, name = {}, None
for line in open("ctar_prot.faa"):
    if line.startswith(">"):
        name = line[1:].split()[0]
        seqs[name] = []
    else:
        seqs[name].append(line.strip())

best = {}
for mrna, parts in seqs.items():
    seq = "".join(parts).rstrip("*").replace(".", "")
    gene = m2g.get(mrna)
    if gene is None:
        continue
    if gene not in best or len(seq) > len(best[gene]):
        best[gene] = seq

with open("ctar_prot.gene.faa", "w") as out:
    for gene, seq in best.items():
        out.write(f">{gene}\n")
        for i in range(0, len(seq), 60):
            out.write(seq[i:i+60] + "\n")

print(f"{len(seqs)} mRNAs -> {len(best)} genes")
