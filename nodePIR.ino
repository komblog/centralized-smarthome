#include <SPI.h>
#include <Mirf.h>
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h>
#include <EEPROM.h>

//Deklarasi Variabel
byte Header = 0;
byte Status = 0;
byte RW = 0;
byte From_ID = 0;
byte To_ID = 0;
byte Jam = 0;
byte Menit = 0;
byte Detik = 0;
byte Nilai = 0;
byte Checksum = 0;
byte General_Purpose = 0;

//char flag=0;
byte alamat = $a; //alamat node ini
char led[5] = {14, 15, 16, 17, 9};
char button[2] = {6, 5};
char sw[3] = {4, 3, 2};
char PIR = 2;

boolean sensor_pir = 0;
boolean flag = 0;

byte out[11];
byte in[11];

byte n = 0;

unsigned long time1, time2, time;

void setup()
{
  Serial.begin(9600);

  //Deklarasi Input Output
  pinMode(button[0], INPUT_PULLUP);
  pinMode(button[1], INPUT_PULLUP);
  pinMode(PIR, INPUT);
  pinMode(led[0], OUTPUT);
  pinMode(led[1], OUTPUT);
  pinMode(led[2], OUTPUT);
  pinMode(led[3], OUTPUT);
  pinMode(led[4], OUTPUT);

  Mirf.spi = &MirfHardwareSpi;
  Mirf.init();
  Mirf.setTADDR((byte *)"serv1");
  Mirf.setRADDR((byte *)"serv1");
  Mirf.payload = 11;
  Mirf.channel = 100;

  Mirf.config();

  digitalWrite(led[0], HIGH);
  digitalWrite(led[1], HIGH);
  digitalWrite(led[2], HIGH);
  digitalWrite(led[3], HIGH);
  digitalWrite(led[4], HIGH);

  // Serial.println("Beginning ... ");

  Header = 'A';
  Status = 'B';
  RW = 'W';
  From_ID = 1;
  To_ID = 2;
  Jam = 3;
  Menit = 4;
  Detik = 5;
  Nilai = 6;
  General_Purpose = 7;
  time1 = millis();
}

void loop()
{
  //awal kode untuk mendeteksi manusia
  time2 = millis();
  time = time2 - time1;
  if (time > 30000 && flag == 1)
  {
    sensor_pir = digitalRead(PIR);

    if (sensor_pir == 1) //simulasi PIR aktif
    {
      Serial.println("PIR AKTIF");
      digitalWrite(led[0], LOW);
      digitalWrite(led[1], LOW);
      digitalWrite(led[2], LOW);
      digitalWrite(led[3], LOW);
      digitalWrite(led[4], LOW);
      delay(1000);
      digitalWrite(led[0], HIGH);
      digitalWrite(led[1], HIGH);
      digitalWrite(led[2], HIGH);
      digitalWrite(led[3], HIGH);
      digitalWrite(led[4], HIGH);

      while (digitalRead(button[0]) == 0)
      {}
      int addr = GetLastAddr(1);
      int i = 0;
      while (i < addr)
      {
        byte AlamatTujuan = EEPROM.read(i);
        i++;
        byte NilaiTujuan = EEPROM.read(i);
        i++;
        SetObject(AlamatTujuan, NilaiTujuan);
      }
    }
    else if (sensor_pir == 0) //simulasi PIR tidak aktif
    {
      flag = 0;
      Serial.println("PIR TIDAK AKTIF");
      digitalWrite(led[0], LOW);
      delay(1000);
      digitalWrite(led[0], HIGH);

      while (digitalRead(button[1]) == 0)
      {}
      int addr = GetLastAddr(0);
      int i = 256;
      while (i < addr)
      {
        byte AlamatTujuan = EEPROM.read(i);
        i++;
        byte NilaiTujuan = EEPROM.read(i);
        i++;
        SetObject(AlamatTujuan, NilaiTujuan);
      }
    }
    time1 = millis();
  }

  terima();
  if (digitalRead(PIR) == 1 && flag == 0)
  {
    flag = 1;

    Serial.println("PIR AKTIF");
    digitalWrite(led[0], LOW);
    digitalWrite(led[1], LOW);
    digitalWrite(led[2], LOW);
    digitalWrite(led[3], LOW);
    digitalWrite(led[4], LOW);
    delay(1000);
    digitalWrite(led[0], HIGH);
    digitalWrite(led[1], HIGH);
    digitalWrite(led[2], HIGH);
    digitalWrite(led[3], HIGH);
    digitalWrite(led[4], HIGH);

    while (digitalRead(button[0]) == 0)
    {}
    int addr = GetLastAddr(1);
    int i = 0;
    while (i < addr)
    {
      byte AlamatTujuan = EEPROM.read(i);
      i++;
      byte NilaiTujuan = EEPROM.read(i);
      i++;
      SetObject(AlamatTujuan, NilaiTujuan);
    }
  }
  //delay(5000);
}//akhir kode untuk mendeteksi manusia

void SetObject(byte AlamatTujuan, byte NilaiTujuan)
{
  General_Purpose = 4;
  To_ID = $b;
  From_ID = $a;
  Nilai = $c;
  assamble_frame();
  kirim();
}

void assamble_frame()
{
  out[0] = Header;
  out[1] = Status;
  out[2] = RW;
  out[3] = From_ID;
  out[4] = To_ID;
  out[5] = Jam;
  out[6] = Menit;
  out[7] = Detik;
  out[8] = Nilai;
  out[9] = General_Purpose;

  out[10] = out[0] ^ out[1] ^ out[2] ^ out[3] ^ out[4] ^ out[5] ^ out[6] ^ out[7] ^ out[8] ^ out[9];
}

void kirim()
{
  Mirf.send((byte *)&out);
  while (Mirf.isSending())
  {}
}

  int GetLastAddr(byte bRule)
  {
    byte data;
    int addr;
    if (bRule == 1)
    {

      for (addr = 0; addr < 255; addr++)
      {
        data = EEPROM.read(addr);
        if (data == 255)
        {
          break;
        }
      }
    }
    else if (bRule == 0)
    {
      for (addr = 256; addr < 512; addr++)
      {
        data = EEPROM.read(addr);
        if (data == 255)
        {
          break;
        }
      }
    }
    return addr;
  }
  void terima()
  {
    int addr;
    int i;
    if (!Mirf.isSending() && Mirf.dataReady())
    {
      Mirf.getData((byte *)&in);
      if (in[4] == alamat)
      {
        Serial.print("n: ");
        Serial.println(n);
        Serial.print("GP: ");
        Serial.println(in[9]);
        Serial.print("Rule: ");
        Serial.println(in[1]);
        if (in[9] != 255)
        {
          if (n == 0) //jika data rule yang pertama
          {
            for (i = 0; i < 512; i++)
            {
              EEPROM.write(i, 255);
            }
            if (in[1] == 1) //Rule untuk PIR Aktif
            {
              addr = 0;
              EEPROM.write(addr, in[9]);
              EEPROM.write((addr + 1),
                           in[8]);
              n++;
              //--------------------------------
              Serial.print("Add Rule: ");
              Serial.print(addr);
              Serial.print(", ");
              Serial.println(in[9]);
              //---------------------------------
            }
            else if (in[1] == 0) //Rule untuk PIR tidak aktif
            {
              addr = 256;
              EEPROM.write(addr, in[9]);
              EEPROM.write((addr + 1), in[8]);
              n++;
              Serial.print("Add Rule: ");
              Serial.print(addr);
              Serial.print(", ");
              Serial.println(in[9]);
            }
          }
          else
          {
            addr = GetLastAddr(in[1]);
            EEPROM.write(addr, in[9]);
            EEPROM.write((addr + 1), in[8]);
            n++;
            //------------------------------------
            Serial.print("Add Rule: ");
            Serial.print(addr);
            Serial.print(", ");
            Serial.println(in[9]);
            //-----------------------------------
          }
        }
        else
        {
          General_Purpose = 255;
          Nilai = n;
          To_ID = 255;
          assamble_frame();
          kirim();
          n = 0;
          //------------------------------------------------
          addr = GetLastAddr(1);
          i = 0;
          while (i < addr)
          {
            Serial.println(EEPROM.read(i));
            i++;
            Serial.println(EEPROM.read(i));
            i++;
          }
          Serial.print("Last 1 ADDR: ");
          Serial.println(addr);
          addr = GetLastAddr(0);
          i = 256;
          while (i < addr)
          {
            Serial.println(EEPROM.read(i));
            i++;
            Serial.println(EEPROM.read(i));
            i++;
          }
          Serial.print("Last 0 ADDR: ");
          Serial.println(addr);
          //------------------------------------------------
        }
      }
    }
  }
