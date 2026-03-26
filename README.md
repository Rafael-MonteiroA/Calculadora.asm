# 🧮 Calculadora em Assembly

Calculadora simples desenvolvida em **Assembly (NASM)** para fins educacionais.

Este projeto foi criado para estudar **programação de baixo nível**, manipulação de registradores e interação básica com o sistema através de chamadas de sistema.

---

## 📚 Sobre o Projeto

A calculadora permite realizar operações matemáticas básicas diretamente pelo terminal.
O objetivo do projeto é aprender:

* Estrutura de programas em **Assembly**
* Uso de **registradores**
* **Syscalls** do Linux
* Entrada e saída no terminal
* Lógica de operações matemáticas em baixo nível

---

## ⚙️ Tecnologias Utilizadas

* **Assembly (NASM)**
* **Linux / WSL**
* **VS Code**
* **Terminal**

---

## 📂 Estrutura do Projeto

```
calculadora_asm/
 ├── calculadora.asm
 └── README.md
```

---

## 🚀 Como Executar

### 1️⃣ Abrir o terminal na pasta do projeto

Exemplo no WSL:

```
cd ~/calculadora_asm
```

---

### 2️⃣ Compilar o código

```
nasm -f elf64 calculadora.asm
```

---

### 3️⃣ Linkar o programa

```
ld calculadora.o -o calculadora
```

---

### 4️⃣ Executar

```
./calculadora
```

---

## 🎯 Objetivo Educacional

Este projeto foi desenvolvido para praticar:

* Programação **low-level**
* Funcionamento interno de programas
* Estrutura de compilação manual

É um ótimo exercício para estudantes de **Ciência da Computação** que querem entender melhor como softwares funcionam por baixo dos frameworks modernos.

---

## 👨‍💻 Autor

**Rafael Monteiro**

Estudante de Ciência da Computação e entusiasta de sistemas operacionais, segurança e programação de baixo nível.

---

## 🔮 Melhorias Futuras

* Suporte a mais operações matemáticas
* Interface melhor no terminal
* Validação de entrada
* Versão com interface gráfica simples
* Integração com projetos maiores de baixo nível
