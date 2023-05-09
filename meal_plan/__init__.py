from multiprocessing import Pool

def process(query):
    return pool.apply(dowork, (query,))

def initialise():
    global prolog
    from pyswip import Prolog
    prolog = Prolog()
    prolog.consult('prolog/makanan.pl')
    prolog.consult('prolog/Code-Vaah.pl')

def dowork(query):
    global prolog
    result = prolog.query(query)
    return list(result)

pool = Pool(None, initialise)

