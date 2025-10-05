# Lexical Analysis In JFlex


### ภาพรวม
สร้างโปรแกรม **Lexical Analyzer (ตัวแยกคำ)** ที่ใช้ในการแยกและจำแนก tokens ต่างๆ ในโค้ด ซึ่งเป็นขั้นตอนแรกของ compiler โปรแกรมจะอ่านไฟล์ข้อความและแยกออกเป็นส่วนประกอบต่างๆ เช่น ตัวดำเนินการ คำสงวน ตัวเลข ตัวแปร เป็นต้น

---

## สิ่งที่โปรแกรมต้องทำได้

### 1. ตรวจจับและจำแนก Tokens

| ประเภท | รายละเอียด | ตัวอย่าง |
|--------|-----------|---------|
| **Operators** | ตัวดำเนินการ | `+`, `-`, `*`, `/`, `=`, `>`, `>=`, `<`, `<=`, `==`, `++`, `--` |
| **Punctuation** | เครื่องหมายวรรคตอน | `(`, `)`, `;` |
| **Keywords** | คำสงวน | `if`, `then`, `else`, `endif`, `while`, `do`, `endwhile`, `print`, `newline`, `read` |
| **Integers** | จำนวนเต็ม | `123`, `12345`, `0`, `999` |
| **Identifiers** | ชื่อตัวแปร | `id1`, `myVar`, `counter` (ต้องขึ้นต้นด้วยตัวอักษร) |
| **Strings** | สตริง | `"Hello World"`, `"Test"` |
| **Comments** | คอมเมนต์ | `/* block comment */`, `// line comment` |

### 2. ฟีเจอร์พิเศษ(เพิ่มเข้ามาเพื่อเสริมความปลอดภัยและรวดเร็ว)

#### Symbol Table
- เก็บรายชื่อ identifiers ที่พบ
- ตรวจสอบว่า identifier ซ้ำหรือไม่
- แสดงข้อความ "new identifier" หรือ "already in symbol table"

#### Error Handling
- หากพบอักขระที่ไม่รู้จัก ให้แสดงข้อผิดพลาดพร้อมตำแหน่ง (บรรทัด, คอลัมน์)
- หยุดการทำงานทันทีเมื่อพบ error

---

## โครงสร้างไฟล์

```
OurProject/
├── lexer/
│   ├── Lex.flex          ← ไฟล์ JFlex specification (เราสร้างเอง)
│   ├── Lex.java          ← ไฟล์ Java ที่ถูกสร้างโดย JFlex
│   └── Lex.class         ← ไฟล์ที่ compile แล้ว
├── jflex-full-1.9.1.jar  ← JFlex tool 
├── input.txt             ← ไฟล์ทดสอบ input
└── README.md             ← คู่มือนี้
```

---

## วิธีการรันโปรแกรม 

### ขั้นตอนที่ 1: เตรียมไฟล์

**สิ่งที่ต้องมี:**
- ✅ `Lex.flex` (ไฟล์ JFlex specification ที่เราเขียน)
- ✅ `jflex-full-1.9.1.jar` (ดาวน์โหลดจาก https://jflex.de/)
- ✅ `input.txt` (ไฟล์ทดสอบ)
- ✅ Java JDK ติดตั้งแล้ว 

**ตรวจสอบ Java:**
```bash
java -version
```
ควรแสดงเวอร์ชันของ Java เช่น `java version "11.0.12"`

---

### ขั้นตอนที่ 2: สร้างไฟล์ทดสอบ (input.txt)

สร้างไฟล์ `input.txt` ในโฟลเดอร์หลัก:

```
A + B
-
*
if
then
id1
id2
id1
"Hello World"
/* This is a comment */
// Line comment
x = 10
y >= 20
counter++
invalid@char
```

---

### ขั้นตอนที่ 3: สร้างไฟล์ Lex.java จาก Lex.flex

เปิด Command Prompt (Windows) หรือ Terminal (Mac/Linux) ที่โฟลเดอร์โปรเจกต์

#### **Windows:**
```cmd
java -jar jflex-full-1.9.1.jar lexer/Lex.flex
```

#### **Mac/Linux:**
```bash
java -jar jflex-full-1.9.1.jar lexer/Lex.flex
```

#### **ผลลัพธ์ที่ควรเห็น:**
```
Reading "lexer/Lex.flex"
Constructing NFA : 124 states in NFA
Converting NFA to DFA : 
.....
Writing code to "lexer/Lex.java"
```

✅ **ไฟล์ `lexer/Lex.java` ถูกสร้างแล้ว**

---

### ขั้นตอนที่ 4: Compile ไฟล์ Java

```bash
javac lexer/Lex.java
```

**หากไม่มี error:** ไม่มีข้อความแสดงออกมา และจะมีไฟล์ `lexer/Lex.class` ถูกสร้างขึ้น

**หากมี error:** ตรวจสอบว่า:
- Java ติดตั้งถูกต้อง
- Path ของไฟล์ถูกต้อง
- ไฟล์ Lex.java ถูกสร้างเรียบร้อย

---

### ขั้นตอนที่ 5: รันโปรแกรม

#### **Windows:**
```cmd
java lexer.Lex input.txt
```

#### **Mac/Linux:**
```bash
java lexer.Lex input.txt
```

---

## Result

```
new identifier: A
operator: +
new identifier: B
operator: -
operator: *
keyword: if
keyword: then
new identifier: id1
new identifier: id2
identifier "id1" already in symbol table
string:"Hello World"
new identifier: x
operator: =
integer: 10
new identifier: y
operator: >=
integer: 20
new identifier: counter
operator: ++
error: invalid character '@' at line 14, column 7
```

---

## 🔧 คำสั่งแบบรวม (Copy-Paste ได้เลย)

### **สำหรับ Windows (Command Prompt):**
```cmd
REM ขั้นตอนที่ 1: สร้าง Lex.java
java -jar jflex-full-1.9.1.jar lexer/Lex.flex

REM ขั้นตอนที่ 2: Compile
javac lexer/Lex.java

REM ขั้นตอนที่ 3: Run
java lexer.Lex input.txt
```

### **สำหรับ Mac/Linux (Terminal):**
```bash
# ขั้นตอนที่ 1: สร้าง Lex.java
java -jar jflex-full-1.9.1.jar lexer/Lex.flex

# ขั้นตอนที่ 2: Compile
javac lexer/Lex.java

# ขั้นตอนที่ 3: Run
java lexer.Lex input.txt
```

---

## 🆘 การแก้ไขปัญหาที่พบบ่อย

### ❌ ปัญหา: "java: command not found"
**สาเหตุ:** Java ยังไม่ได้ติดตั้งหรือไม่อยู่ใน PATH

**วิธีแก้:**
1. ดาวน์โหลดและติดตั้ง Java JDK จาก https://www.oracle.com/java/technologies/downloads/
2. เพิ่ม Java ลงใน PATH environment variable

**ตรวจสอบ:**
```bash
java -version
javac -version
```

---

### ❌ ปัญหา: "Could not find or load main class lexer.Lex"
**สาเหตุ:** ไฟล์ยังไม่ถูก compile หรือรันจากโฟลเดอร์ผิด

**วิธีแก้:**
1. ตรวจสอบว่ามีไฟล์ `lexer/Lex.class` หรือไม่
2. รัน compile อีกครั้ง: `javac lexer/Lex.java`
3. ตรวจสอบว่ารันจากโฟลเดอร์หลักของโปรเจกต์

---

### ❌ ปัญหา: "Error: Unable to access jarfile jflex-full-1.9.1.jar"
**สาเหตุ:** ไฟล์ JFlex jar ไม่อยู่ในโฟลเดอร์ปัจจุบัน

**วิธีแก้:**
1. ตรวจสอบว่าไฟล์ `jflex-full-1.9.1.jar` อยู่ในโฟลเดอร์เดียวกัน
2. ใช้ path แบบเต็ม: `java -jar C:\path\to\jflex-full-1.9.1.jar lexer/Lex.flex`

---

### ❌ ปัญหา: "package lexer does not exist"
**สาเหตุ:** Compile จากโฟลเดอร์ผิดหรือ package structure ไม่ถูกต้อง

**วิธีแก้:**
1. Compile จากโฟลเดอร์หลัก (ไม่ใช่จากใน lexer/)
2. ใช้คำสั่ง: `javac lexer/Lex.java` (มี lexer/ ด้านหน้า)

---

### ❌ ปัญหา: JFlex สร้าง Lex.java แล้ว แต่มี error ตอน compile
**สาเหตุ:** Syntax error ในไฟล์ Lex.flex

**วิธีแก้:**
1. ตรวจสอบ syntax ในไฟล์ .flex
2. ดูข้อความ error อย่างละเอียด
3. ตรวจสอบว่า pattern ต่างๆ เขียนถูกต้อง (เช่น string pattern)



## วิดีโอ

### เนื้อหาที่ต้องมีในวิดีโอ:

1. **แนะนำสมาชิก** 
   - แนะนำตัวสมาชิกทุกคนในกลุ่ม


2. **อธิบาย Lex.flex** 
   - อธิบาย **ทุกบรรทัด** ใน .flex file
   - อธิบาย regular expressions ที่ใช้
   - อธิบาย Symbol Table implementation
   - อธิบาย Error handling

3. **อธิบายโค้ด Lex.java** 
   - อธิบายโค้ดที่ JFlex generate ให้
   - อธิบายการทำงานของ lexer

4. **Demo การทำงาน** 
   - รันโปรแกรมกับ test cases หลายแบบ
   - แสดงทุก token types
   - แสดง symbol table functionality
   - แสดง error handling

- จะต้องอธิบายภาพรวมของโปรเจกต์ว่าคืออะไร และทำอะไรไปเพิ่ม ภูมิ
    - บรรทัดที่ 23 - 35 ปลายฝน
    - บรรทัดที่ 38 - 43 แพตตี้
    - บรรทัดที่ 45 - 55 ปลายฝน 
    - บรรทัดที่ 57 - 62 ซัน
    - บรรทัดที่ 64 - 71 ปันๆ
    - บรรทัดที่ 73 - 79 น้อง
    - บรรทัดที่ 81 - 85 อิงค์
    - บรรทัดที่ 82 - 92 อัย (อธิบายด้วยว่า Error Handling คือ)
- อธิบายไฟล์ Lexer.class และ Lexer.java ขุนน้ำ (ไฟล์ถูกสร้างอัตโนมัติหลังจาก compile ใน step 3, 4)

**รันได้ก็รัน รันไม่ได้ก็อธิบายแค่ในโค้ด Lexer.flex พอ เดี่ยวตอนตัดต่อค่อยตัดจากคอมกูไปก็ได้**

เมื่ออัดคลิปเสร็จแล้ว ไปส่งในนี้ เดี่ยวหาคนตัดต่อ
https://drive.google.com/drive/folders/1qhWcYbWZDCINnr0kX0Xthk5LTLTD9TST?usp=sharing
---

## เอกสารอ้างอิง

- JFlex Manual: https://jflex.de/manual.html
- JFlex Download: https://jflex.de/download.html
- Java Documentation: https://docs.oracle.com/en/java/

---

**Good Luck! 🎓**