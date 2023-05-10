from multiprocessing import Pool

def process(query):
    with Pool(initializer=initialize_worker) as pool:
        res = pool.apply_async(dowork, (query,))
        pool.close()
        pool.join()
        return res.get()

def initialize_worker():
    global prolog
    from pyswip import Prolog
    prolog = Prolog()
    prolog.consult('prolog/makanan.pl')
    prolog.consult('prolog/Code-Vaah.pl')

def dowork(query):
    global prolog
    result = prolog.query(query)
    return list(result)
