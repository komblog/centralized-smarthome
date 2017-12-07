#include "SoftwareSerial.h"
#include <SPI.h> //library spi
#include <Mirf.h> //library komunikasi untuk nrf24l01
#include <nRF24L01.h> //library komunikasi untuk nrf24l01
#include <MirfHardwareSpiDriver.h> //library komunikasi spi

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
char button[2] = {6, 5};
char sw[3] = {4, 3, 2};

byte out[11];
byte in[11];

void setup()
{
  Serial.begin(9600);
  
  //Deklarasi Input Output
  pinMode(button[0], INPUT_PULLUP);
  pinMode(button[1], INPUT_PULLUP);
  
  /*pinMode(sw[0], INPUT_PULLUP);
    pinMode(sw[1], INPUT_PULLUP);
    pinMode(sw[2], INPUT_PULLUP);*/
    
  Mirf.spi = &MirfHardwareSpi;
  // Mirf.cePin = A5;
  // Mirf.csnPin = 10;
  Mirf.init();
  
  Mirf.setTADDR((byte *)"serv1");
  Mirf.setRADDR((byte *)"serv1");
  Mirf.payload = 11;
  Mirf.channel = 100;
  
  Mirf.config();
  
  pinMode(9, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A3, OUTPUT);
  digitalWrite(9, HIGH);
  digitalWrite(A2, HIGH);
  digitalWrite(A3, HIGH);
  
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
}

void loop()
{
  // digitalWrite(A2, LOW);
  if (digitalRead(button[0]) == 0)
  {
    General_Purpose = 4;
    To_ID = 255;
    From_ID = alamat;
    RW = 'W';
    Nilai = 100; //diisi ID untuk FP, diisi 0/100 untuk PIR
    assamble_frame();
    kirim();
    Serial.println("Terkirim!");
    delay(1000);
  }
  if (digitalRead(button[1]) == 0)
  {
    To_ID = 1;
    From_ID = alamat;
    RW = 'R';
    Nilai = 100;
    assamble_frame();
    kirim();
    
    To_ID = 2;
    From_ID = alamat;
    RW = 'R';
    Nilai = 100;
    assamble_frame();
    kirim();
    
    To_ID = 5;
    From_ID = alamat;
    RW = 'R';
    Nilai = 100;
    assamble_frame();
    kirim();
  }
  terima();
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

void terima()
{
  if (!Mirf.isSending() && Mirf.dataReady())
  {
    Serial.println("Data diterima!!!");
    Mirf.getData((byte *)&in);
    Serial.println(in[4], DEC);
    Serial.println(in[2]);
    Serial.println(in[8], DEC);
    if (in[4] == alamat && in[8] == 0)
    {
      // Serial.print('done');
      digitalWrite(A2, HIGH);
      General_Purpose = 7;
      To_ID = 255;
      From_ID = alamat;
      assamble_frame();
      kirim();
    }
    else if (in[4] == alamat && in[8] == 100)
    {
      digitalWrite(A2, LOW);
      General_Purpose = 7;
      To_ID = 255;
      From_ID = alamat;
      assamble_frame();
      kirim();
    }
  }
}
