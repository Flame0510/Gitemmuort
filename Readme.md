# 🔫 **GITEMMUORT**

### _"O Sistema p' Git"_ - Wrapper Git in Napoletano Stile Gomorra

**by** `Flame0510` 🚀

---

## 📖 **Che cos'è?**

**GITEMMUORT** è un wrapper interattivo per Git che trasforma i comandi in **dialetto napoletano**, ispirato allo stile di Gomorra. Ma non è solo per ridere! Dopo anni di utilizzo, è diventato il mio strumento quotidiano per lavorare **più velocemente** con Git grazie ai **comandi rapidi** e abbreviati.

### ✨ **Perché usarlo?**

-   🎭 **Divertimento garantito**: comandi in napoletano che rendono Git meno noioso
-   ⚡ **Produttività**: alias brevi (1-2 caratteri) per operazioni comuni
-   🛡️ **Sicurezza**: controlli automatici per evitare errori
-   🎨 **Interfaccia colorata**: output chiaro e leggibile
-   🚀 **Efficienza provata**: usato da anni per lavoro quotidiano

---

## 🎯 **Installazione Rapida**

```bash
# Clona la repo
git clone https://github.com/Flame0510/Gitemmuort.git
cd Gitemmuort

# Rendi eseguibile
chmod +x gitemmuort_V_1_0.sh

# Avvia
./gitemmuort_V_1_0.sh
```

---

## 📚 **Comandi - Due Modi per Ogni Azione**

Ogni comando ha **2 alias principali**:

1. 🔥 **Napoletano Gomorra** (il più divertente e caratteristico)
2. ⚡ **Abbreviato** (per velocità massima - 1-2 caratteri)

_Nota: Alcuni comandi mantengono anche forme intermedie per retrocompatibilità_

### 📦 **Clone & Fetch**

| Napoletano          | Breve | Git         |
| ------------------- | ----- | ----------- |
| `pigliat 'a roba`   | `cln` | `git clone` |
| `controlla 'o giro` | `f`   | `git fetch` |

### 🏢 **Branch Management**

| Napoletano            | Breve | Git                     |
| --------------------- | ----- | ----------------------- |
| `vir 'e clan`         | `b`   | `git branch`            |
| `fonda nu clan`       | `ab`  | `git checkout -b`       |
| `fai sapé a tutt`     | `pb`  | `git push -u origin`    |
| `leva 'o clan`        | `db`  | `git branch -D`         |
| `sciogliere stu clan` | `dcb` | elimina branch corrente |

### 🔄 **Navigation (Checkout)**

| Napoletano           | Breve | Git                   |
| -------------------- | ----- | --------------------- |
| `passa a n'atu clan` | `ch`  | `git checkout` (menu) |
| `torna dò sistema`   | `chm` | checkout master/main  |
| `torna arè`          | `chl` | `git checkout -`      |

### 🤝 **Merge & Rebase**

| Napoletano               | Breve  | Git                     |
| ------------------------ | ------ | ----------------------- |
| `alleat 'e clan`         | `m`    | `git merge`             |
| `mettit sottò sistem`    | `rbm`  | `git rebase master`     |
| `aggiorna e mettit sott` | `prbm` | pull + rebase           |
| `vai avanti`             | `rbc`  | `git rebase --continue` |
| `ferma tutt`             | `rba`  | `git rebase --abort`    |

### 📤 **Push & Pull**

| Napoletano       | Breve | Git              |
| ---------------- | ----- | ---------------- |
| `pigl 'a merce`  | `p`   | `git pull`       |
| `manna 'a merce` | `pu`  | `git push`       |
| `spacca tutt`    | `puf` | `git push -f` ⚠️ |

### 📝 **Add, Status & Commit**

| Napoletano            | Breve | Git          |
| --------------------- | ----- | ------------ |
| `mett dintò sacc`     | `a`   | `git add .`  |
| `comm stann 'e ccose` | `st`  | `git status` |
| `segna 'a moviment`   | `c`   | add + commit |

### 💾 **Stash**

| Napoletano         | Breve | Git               |
| ------------------ | ----- | ----------------- |
| `scunne 'a roba`   | `as`  | add + stash       |
| `scunne`           | `s`   | `git stash`       |
| `tira for 'a roba` | `sa`  | `git stash apply` |

### 📜 **Log & History**

| Napoletano      | Breve | Git       |
| --------------- | ----- | --------- |
| `vir 'a storia` | `l`   | `git log` |

### ⏮️ **Reset**

| Napoletano                             | Breve | Git                   |
| -------------------------------------- | ----- | --------------------- |
| `torna arrèt accort`                   | `rs`  | `git reset --soft`    |
| `brucia tutt cos` / `resetta tutt cos` | `rh`  | `git reset --hard` ⚠️ |

### 🗜️ **Squash**

| Napoletano           | Breve | Descrizione                         |
| -------------------- | ----- | ----------------------------------- |
| `accumpagna 'e cose` | `sq`  | squash N commit con nuovo messaggio |
| `accumpagna accussì` | `sql` | squash mantenendo ultimo messaggio  |

### 🔧 **Utilità**

| Comando                | Breve | Azione             |
| ---------------------- | ----- | ------------------ |
| `help`                 | `h`   | mostra questo menu |
| `restart`              | `r`   | riavvia il banner  |
| `pulisci e ricomincia` | `cr`  | clear + restart    |
| `esci` / `exit`        | `q`   | esci da gitemmuort |

---

## 💡 **Esempi di Utilizzo Rapido**

```bash
# Workflow tipico (veloce)
st              # Vedi cosa è cambiato
a               # Aggiungi tutto
c               # Commit con messaggio
pu              # Push

# Con stile Gomorra (divertente)
comm stann 'e ccose    # Status
mett dintò sacc        # Add
segna 'a moviment      # Commit
manna 'a merce         # Push

# Cambio branch veloce
ch              # Menu interattivo
chm             # Torna a master
chl             # Torna al precedente

# Reset pericoloso (unico con forma intermedia)
brucia tutt cos        # oppure: resetta tutt cos | rh
```

---

## 🎯 **Perché lo uso per lavoro**

Dopo anni di utilizzo, GITEMMUORT è diventato parte del mio workflow perché:

✅ **Velocità**: `st`, `a`, `c`, `pu` sono più veloci di scrivere comandi Git completi  
✅ **Sicurezza**: controlli automatici prevengono errori comuni  
✅ **Interattività**: menu per checkout e merge riducono gli errori di digitazione  
✅ **Consistenza**: stesso comportamento su tutti i progetti  
✅ **Divertimento**: il dialetto napoletano rende il lavoro meno monotono

---

## 🛡️ **Caratteristiche di Sicurezza**

-   ✅ Verifica automatica di essere in una repo Git
-   ✅ Controllo esistenza branch corrente
-   ✅ Previene eliminazione del branch principale
-   ✅ Validazione input numerico per reset/squash
-   ✅ Gestione errori centralizzata e chiara
-   ✅ Conferme per operazioni distruttive

---

## 🤝 **Contributi**

Pull requests benvenute! Per modifiche importanti, apri prima un issue.

---

## 📜 **Licenza**

[MIT](LICENSE.md)

---

## 👨‍💻 **Autore**

**Michele Tornello** (Flame0510)

_"Fatto a Catania con amore e un po' di Gomorra"_ 🍕🔫
