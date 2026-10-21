// Equivalencias de las 89 categorías originales del CSV de 100 medicamentos.
// Mantiene compatible el catálogo local anterior con la normalización del SQL.
// Las categorías nuevas desconocidas se conservan sin inferir clasificaciones.
const categoriasLegadas = <String, List<String>>{
  "analgesicos, antiinflamatorios y antipireticos": [
    "Analgésicos",
    "Antiinflamatorios",
    "Antipiréticos"
  ],
  "analgesicos, antiinflamatorios y antipireticos (analgesico opiaceo)": [
    "Analgésicos",
    "Antiinflamatorios",
    "Antipiréticos"
  ],
  "analgesicos, antiinflamatorios y antipireticos (combinados)": [
    "Analgésicos",
    "Antiinflamatorios",
    "Antipiréticos"
  ],
  "analgesicos, antiinflamatorios y antipireticos (inhibidor selectivo cox-2)":
      ["Analgésicos", "Antiinflamatorios", "Antipiréticos"],
  "analgesicos, antiinflamatorios y antipireticos / antiagregante plaquetario":
      [
    "Analgésicos",
    "Antiinflamatorios",
    "Antipiréticos",
    "Antiagregantes plaquetarios"
  ],
  "anestesico local / antiarritmico clase ib": [
    "Anestésicos locales",
    "Antiarrítmicos"
  ],
  "ansiolitico / anticonvulsivante / miorrelajante (benzodiazepina)": [
    "Ansiolíticos",
    "Anticonvulsivantes",
    "Relajantes musculares"
  ],
  "ansiolitico / benzodiazepina de accion corta-intermedia": ["Ansiolíticos"],
  "antiagregante plaquetario / inhibidor irreversible del receptor p2y12 de adp":
      ["Antiagregantes plaquetarios"],
  "antianemico / suplemento de hierro inorganico (hierro ii)": [
    "Antianémicos",
    "Suplementos de hierro"
  ],
  "antianemico / suplemento de hierro organico": [
    "Antianémicos",
    "Suplementos de hierro"
  ],
  "antibacteriano topico": ["Antibacterianos tópicos"],
  "antibioticos (aminoglucosidos)": ["Antibióticos"],
  "antibioticos (betalactamicos / penicilinas de deposito)": ["Antibióticos"],
  "antibioticos (betalactamicos / penicilinas)": ["Antibióticos"],
  "antibioticos (betalactamicos con inhibidor de betalactamasas)": [
    "Antibióticos"
  ],
  "antibioticos (cefalosporinas de 1ª generacion)": ["Antibióticos"],
  "antibioticos (cefalosporinas de 3ª generacion)": ["Antibióticos"],
  "antibioticos (fluoroquinolonas de 3ª generacion)": ["Antibióticos"],
  "antibioticos (fluoroquinolonas)": ["Antibióticos"],
  "antibioticos (lincosamidas)": ["Antibióticos"],
  "antibioticos (macrolidos)": ["Antibióticos"],
  "antibioticos (nitrofuranos / antiseptico urinario)": ["Antibióticos"],
  "antibioticos (sulfonamidas con trimetoprima)": ["Antibióticos"],
  "antibioticos (tetraciclinas)": ["Antibióticos"],
  "antibioticos / antiparasitarios (nitroimidazoles)": [
    "Antibióticos",
    "Antiparasitarios"
  ],
  "anticoagulante oral / antagonista de la vitamina k": ["Anticoagulantes"],
  "anticonceptivo hormonal combinado continuo": ["Anticonceptivos hormonales"],
  "anticonceptivo hormonal de emergencia (progestageno)": [
    "Anticonceptivos hormonales"
  ],
  "anticonceptivo hormonal inyectable trimestral (progestageno solo)": [
    "Anticonceptivos hormonales"
  ],
  "anticonvulsivante / ansiolitico (benzodiazepina de accion prolongada)": [
    "Anticonvulsivantes",
    "Ansiolíticos"
  ],
  "anticonvulsivante / antiepileptico (hidantoina)": [
    "Anticonvulsivantes",
    "Antiepilépticos"
  ],
  "antidepresivo / inhibidor selectivo de la recaptacion de serotonina (isrs potente)":
      ["Antidepresivos"],
  "antidepresivo / inhibidor selectivo de la recaptacion de serotonina (isrs)":
      ["Antidepresivos"],
  "antidepresivo triciclico (atc) / modulador del dolor neuropatico": [
    "Antidepresivos",
    "Moduladores del dolor neuropático"
  ],
  "antidiarreicos (agonista opioide periferico)": ["Antidiarreicos"],
  "antidiarreicos y protectores de la mucosa gastrica": [
    "Antidiarreicos",
    "Protectores gástricos"
  ],
  "antiepileptico / estabilizador del animo / analgesico para dolor neuropatico":
      ["Antiepilépticos", "Estabilizadores del ánimo", "Analgésicos"],
  "antiepileptico de segunda generacion": ["Antiepilépticos"],
  "antiespasmodico / anticolinergico amonio cuaternario": [
    "Antiespasmódicos",
    "Anticolinérgicos"
  ],
  "antiflatulentos": ["Antiflatulentos"],
  "antigripal multisintomatico / analgesico, antihistaminico y descongestivo": [
    "Antigripales",
    "Analgésicos",
    "Antihistamínicos",
    "Descongestionantes"
  ],
  "antigripales / descongestionantes": ["Antigripales", "Descongestionantes"],
  "antihelmintico de amplio espectro (benzimidazol)": ["Antihelmínticos"],
  "antihelmintico de amplio espectro / carbamato de benzimidazol": [
    "Antihelmínticos"
  ],
  "antihiperglucemiante / biguanida": ["Antihiperglucemiantes"],
  "antihipertensivos (ara ii)": ["Antihipertensivos"],
  "antihipertensivos (bloqueador de canales de calcio)": ["Antihipertensivos"],
  "antihipertensivos (ieca de accion corta)": ["Antihipertensivos"],
  "antihipertensivos (ieca)": ["Antihipertensivos"],
  "antihipertensivos / antiarritmicos (betabloqueador β1)": [
    "Antihipertensivos",
    "Antiarrítmicos"
  ],
  "antihistaminicos (1ª generacion)": ["Antihistamínicos"],
  "antihistaminicos (2ª generacion)": ["Antihistamínicos"],
  "antimigranoso / agonista selectivo serotoninergico (alcaloide del cornezuelo)":
      ["Antimigrañosos"],
  "antiparasitario / antihelmintico y ectoparasiticida (avermectina)": [
    "Antiparasitarios",
    "Antihelmínticos",
    "Ectoparasiticidas"
  ],
  "antiparasitarios y antimicoticos (imidazol)": [
    "Antiparasitarios",
    "Antimicóticos"
  ],
  "antiparasitarios y antimicoticos (polieno)": [
    "Antiparasitarios",
    "Antimicóticos"
  ],
  "antiparasitarios y antimicoticos (triazol)": [
    "Antiparasitarios",
    "Antimicóticos"
  ],
  "antitusigenos": ["Antitusígenos"],
  "antiulcerosos (antagonista h2)": ["Antiulcerosos"],
  "antiulcerosos (inhibidor de la bomba de protones - ibp)": ["Antiulcerosos"],
  "antiulcerosos (inhibidor de la bomba de protones - s-isomero)": [
    "Antiulcerosos"
  ],
  "antiacidos locales neutralizantes": ["Antiácidos"],
  "analogo sintetico de la prostaglandina e1 (pge1) / uterotonico y protector gastrico":
      ["Uterotónicos", "Protectores gástricos"],
  "broncodilatadores (agonista beta-2 de corta accion)": ["Broncodilatadores"],
  "corticoides inhalados / nasales": ["Corticoides"],
  "corticoides sinteticos": ["Corticoides"],
  "diureticos de asa": ["Diuréticos"],
  "ectoparasiticida / escabicida y pediculicida (piretroide sintetico)": [
    "Ectoparasiticidas",
    "Escabicidas",
    "Pediculicidas"
  ],
  "factor vitaminico antianemico / suplemento nutricional": [
    "Vitaminas",
    "Antianémicos",
    "Suplementos nutricionales"
  ],
  "hipoglucemiante / sulfonilurea de segunda generacion": ["Hipoglucemiantes"],
  "hipoglucemiante / sulfonilurea de tercera generacion": ["Hipoglucemiantes"],
  "hipoglucemiante parenteral / analogo de insulina de accion prolongada (basal)":
      ["Hipoglucemiantes"],
  "hipoglucemiante parenteral / insulina de accion intermedia": [
    "Hipoglucemiantes"
  ],
  "hipolipemiante / inhibidor de la hmg-coa reductasa (estatina de alta potencia)":
      ["Hipolipemiantes"],
  "hormona tiroidea sustitutiva": ["Hormonas tiroideas"],
  "laxantes osmoticos": ["Laxantes"],
  "mucoliticos y expectorantes": ["Mucolíticos", "Expectorantes"],
  "oxitocico / hormona uterotonica sintetica": ["Oxitócicos", "Uterotónicos"],
  "rehidratante oral / repositor de electrolitos y fluidos": [
    "Rehidratantes",
    "Reposición de electrólitos y fluidos"
  ],
  "relajante muscular de accion central / anticolinergico": [
    "Relajantes musculares",
    "Anticolinérgicos"
  ],
  "solucion electrolitica isotonica parenteral / irrigador": [
    "Soluciones electrolíticas",
    "Irrigadores"
  ],
  "suplemento mineral y vitaminico / remineralizante oseo": [
    "Suplementos minerales",
    "Suplementos vitamínicos",
    "Remineralizantes óseos"
  ],
  "suplemento vitaminico neurotropo": ["Suplementos vitamínicos"],
  "topicos y otros comunes": ["Tópicos"],
  "topicos y otros comunes (corticoides potentes)": ["Tópicos", "Corticoides"],
  "vitamina hidrosoluble / antioxidante": ["Vitaminas", "Antioxidantes"],
  "vitamina hidrosoluble / factor antianemico": ["Vitaminas", "Antianémicos"],
  "vitamina liposoluble / regulador del metabolismo fosfocalcico": [
    "Vitaminas",
    "Reguladores del metabolismo fosfocálcico"
  ],
};
