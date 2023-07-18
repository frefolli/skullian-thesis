# Script

## 2 - Arcan

Arcan e' un software usato nei processi di valutazione e qualita' del software per individuare gli Architectural Smells, ovvero problemi di design architetturale nei progetti software. Prima fa uso di software di terze parti, quali Language Server o framework di runtime (uno per linguaggio di programmazione), per costruire un Grafo dei Componenti e delle Dipendenze fra essi. Quindi esplora questo grafo per analizzare le struttura, il numero delle dipendenze e varie metriche (come LoC) per identificare gli Architectural Smell. Al momento e' in grado di identificare questi 4 tipi di smell.

## 3 - Arcan

Questo e' uno schema del Grafo delle Dipendenze costruito da Arcan. Come nodi troviamo i componenti divisi in tre tipologie, function, unit e container, che corrispondono semanticamente ai tipi java Funzione, Classe e Package. Quindi gli archi rappresentano le dipendenze tra i componenti: alcuni esempi sono definedBy, isChildOf, includes e dependsOn. Quest'ultima e' un termine ombrello per generiche dipendenze di tipo dinamico, ovvero che fanno riferimento ad un uso attivo di un altro componente.

## 4 - Dependency Graph

Lo scopo di questa tesi e' costruire un Grafo delle Dipendenze simile a quello di Arcan senza usare software distinti per ogni linguaggio di programmazione che si vuole supportare. Un esempio di tale grafo e' riportato nella slide. Come si puo' notare anche qui i nodi sono i componenti, ma a differenza di Arcan si va a dettagliare su attributi, campi, sottoclassi ... etc come entita' separate. Inoltre, a parte le piu' tradizionali definedBy, includes, isChildOf troviamo una distinzione piu' netta sul tipo semantico della dipendenza. Quindi per esempio abbiamo una chiamata della funzione Animal.eat dalla funzione main esplicitata come arco etichettato con la stringa calls.

Per realizzare questo grafo ci si avvarra' del linguaggio di programmazione Rust e di due librerie combinabili.

## 5 - Tree Sitter

Tree Sitter e' una libreria che permette di costruire parser per linguaggi di programmazione specificando una grammatica. Un parser Tree Sitter produrra' un Concrete Syntax Tree, ovvero un albero sintattico che rappresenta l'espansione della grammatica utilizzata per fare il parsing del codice sorgente, il quale una volta modificato il sorgente potra' essere riciclato per costruire incrementalmente il nuovo albero sintattico. Questo albero sintattico e' quindi disponibile nella rappresentazione in forma di sexp; un esempio di Concrete Syntax Tree prodotto dal parser per Java e' presente nella slide corrente. Tree Sitter definisce anche un Query Language con cui progettare ed eseguire delle query per trovare sexp all'interno dell'albero sintattico.

## 6 - Stack Graph

Stack Graph invece e' una libreria che abilita il programmatore ad implementare dei grafi che permettono di risolvere le reference all'interno del codice. Tramite una grammatica si specificano delle regole in base a cui costruire questo grafo processando il Concrete Syntax Tree prodotto da Tree Sitter e si puo' in seguito risolvere le occorrenze di reference identificando il punto del codice dove sono state definite. Nell'esempio in figura si risolvono le reference dei tipi utilizzati nella definizione del main.

## 7 - Costruzione del Dependency Graph

Il processo di costruzione del Grafo delle Dipendenze consistera' in tre fasi successive.

## 8 - Costruzione del Dependency Graph

Per prima cosa si costruisce incrementalmente lo Stack Graph (che viene inizializzato vuoto) iterando su tutti i file sorgente del progetto. Cosa importante e' notare come non sia richiesto che tutti questi file siano scritti nello stesso linguaggio ma e' possibile usare progetti misti.

## 9 - Costruzione del Dependency Graph

Si procede quindi a risolvere le reference del progetto. Ogni reference che e' stata risolta con successo viene associata tramite una mappa al nodo di definizione che e' stato trovato.

## 10 - Costruzione del Dependency Graph

Infine si effettua una esplorazione ricorsiva sullo Stack Graph (una visita di tipo Depth First) per identificare tutti i nodi che definiscono componenti (per i quali si cerca o si crea un nodo nel nuovo Grafo delle Dipendenze) e per ogni reference trovata che e' stata risolta nel passo precedente si forma un arco di dipendenza tra il nodo di definizione (che sara' associato ad un componente) e il componente "padre" della reference (ex: la funzione in cui si trova una reference).

## 11 - Validazione - Test ad Hoc

Si passa ora alla valutazione di quello che e' stato implementato. In questa slide troviamo un istogramma che rappresenta l'esito dei test "individuali" progettati durante lo sviluppo del prototipo. Nell'asse delle ascisse si trovano le dipendenze che sono state oggetto dei test. Come si puo' notare tutte le dipendenze bersaglio sono state individuate.

## 12 - Validazione - Benchmark

Quindi e' stato eseguito un test comune per Arcan e il prototipo utilizzato da Arcan stesso per valutare le proprie capacita'. Esso e' stato realizzato basandosi su un paper di Pruijt et Al, che descrive uno schema per la valutazione del sistemi di analisi statica delle dipendenze (messo in footer). Nell'asse delle ascisse ancora una volta troviamo le dipendenze bersaglio. Ebbene nessuno dei due software risulta perfetto, anche se Arcan riesce a rilevare un paio di dipendenze in piu' rispetto al prototipo.

## 13 - Comparazione con Arcan

Per valutare anche le performance dei due software si e' deciso di cronometrare l'analisi di essi su vari progetti reali. In questo scenario Arcan risulta nettamente superiore, ed addirittura il Prototipo non termina l'esecuzione in un tempo accettabile nel caso di Guava e Fastjson.

## 14 - Lezioni Imparate

Le basse prestazioni del Prototipo sono dovute a vari fattori: il primo e piu' importante fra essi e' la dimensione dello Stack Graph che viene costruito su progetti non triviali. Trattandosi pur sempre di una esplorazione di grafo, Stack Graph ha molte difficolta' ad esplorare grafi di grandi dimensioni, impiegando molto tempo o addirittura essendo troncato prima dall'euristica anti ciclo (determinando la non risoluzione delle reference piu' complesse). Parlando di reference irrisolvibili bisogna anche annoverare le reference a componenti di librerie esterne o in generale componenti non definiti all'interno del codice sorgente, che oltre a non essere risolti fanno perdere ulteriore tempo al prototipo.

Sono presenti anche alcuni "problemi" di implementazione legati alla mancanza di un progetto per attuare la parallelizzazione e alla mancata implementazione delle analisi differenziali di Tree Sitter all'interno della libreria Stack Graph.

Dopo di che, il fatto di dover sviluppare per ogni linguaggio di programmazione una grammatica per Stack Graph non e' compito da poco. Se esse non richiedono generalmente uno sforzo eccessivo, sono comunque tediose da progettare e necessitano talvolta nuove soluzioni per sfruttare alcune feature del linguaggio che sono nuove rispetto a quelle comuni ad altri linguaggi, e di cui si dispone la conoscenza di un template di soluzione. Queste grammatiche presentano anche la possibilita' di avere conflitti di reference all'interno dello Stack Graph e quindi necessitano di particolare attenzione.

## 15 - Saluti

In conclusione, e' possibile sviluppare una soluzione basata su Tree Sitter e Stack Graph per l'estrazione delle dipendenze, ma non e' praticabile ne' piu' efficiente del metodo tradizionale usato da Arcan.
