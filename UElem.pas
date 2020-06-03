unit UElem;

interface
uses Graphics, Types, SysUtils;
const
  BackColor=clWhite;
type
	TElem = class
	private
		FCanvas:TCanvas;
		FX,FY:integer; //����� ��������
		FColor:TColor;
    FSmallSize:Integer;
		FKey:integer;
    procedure SetColor(const Value: TColor);
    procedure Setx(const Value: integer); //���� ��-� ������������� ����� �� �������
	public
		constructor Create(ACanvas: TCanvas; ASmallSize:Integer; AX, AY: integer; AColor:TColor);
		destructor Destroy; override;
    procedure SetRandom;
    procedure Draw(IsVisible:boolean; fi: real);
    function AffineRotate(x:real; y:real; fi:real):TPoint;
		procedure Show (fi: real);
		procedure Hide;
		procedure MoveBy(dx,dy:integer);
		property Key:integer read FKey;
		property X:integer read FX write Setx;
		property Color:TColor read FColor write SetColor;
	end;


implementation

{ TElem }

constructor TElem.Create(ACanvas: TCanvas; ASmallSize:Integer; AX, AY: integer; AColor:TColor);
begin
  FCanvas:=ACanvas;
  FX:=AX;
  FSmallSize:=ASmallSize;
  FY:=AY;
  FColor:=AColor;
  FKey:=0;
end;

destructor TElem.Destroy;
begin
  Hide;
  inherited;
end;

function TElem.AffineRotate(x:real; y:real; fi:real):TPoint;
begin
  result:=Point(round((x*cos(fi)) - (y*sin(fi)) + Fx), round((x*sin(fi)) + (y*cos(fi))+Fy ));
end;


procedure TElem.Draw(IsVisible: boolean; fi:real);
const
  cn = 11;
var
  p : array of TPoint;
  i:integer;
  w,h:Integer;
  s:string;
  da,a:real;
begin
  with FCanvas do
    begin
      if IsVisible
        then
          begin
            Pen.Color:=FColor;
            Font.Color:=clBlack;
          end
        else
          begin
            Pen.Color:=BackColor;
            Font.Color:=BackColor;
          end;
       SetLength(P,cn);
       p[0]:=AffineRotate(+FSmallSize, FSmallSize, fi);
       p[1]:=AffineRotate(+FSmallSize, -FSmallSize, fi);
       p[2]:=AffineRotate(0, -FSmallSize*2, fi);
       p[3]:=AffineRotate(-FSmallSize, -FSmallSize, fi);
       p[4]:=AffineRotate(-FSmallSize, FSmallSize, fi);
       p[5]:=AffineRotate(-FSmallSize*1.5, FSmallSize*2, fi);
       p[6]:=AffineRotate(-FSmallSize*1.5, FSmallSize*3, fi);
       p[7]:=AffineRotate(-FSmallSize, FSmallSize*2, fi);
       p[8]:=AffineRotate(FSmallSize, FSmallSize*2, fi);
       p[9]:=AffineRotate(FSmallSize*1.5, FSmallSize*3, fi);
       p[10]:=AffineRotate(FSmallSize*1.5, FSmallSize*2, fi);
      Polygon(p);
      s:=inttostr(FKey);
      Font.Style:=[fsBold];
      w:=TextWidth(s) div 2;
      h:=TextHeight(s) div 2;
      Textout(FX-w,Fy-h,s);
      finalize(p);
    end;
end;
procedure TElem.Hide;
begin
  Draw(False, 0);
  Draw(False, pi);
  Draw(False, pi/2);
  Draw(False, -pi/2);
end;

procedure TElem.MoveBy(dx, dy: integer);
var fi:real;
begin
  if dx=0 then
    if dy>0 then
      fi:=pi
    else fi:= 0
  else if dx>0 then
          fi:=pi/2
       else fi:= -pi/2;
  Hide;
  FX:=FX+dx;
  FY:=FY+dy;
  Show(fi);
end;

procedure TElem.SetColor(const Value: TColor);
begin
  Hide;
  FColor:=Value;
  Show(0)
end;

procedure TElem.SetRandom;
begin
  FKey:= Random(99)+1;
end;

procedure TElem.Setx(const Value: integer);
begin
  FX := Value;
end;

procedure TElem.Show(fi:real);
begin
  Draw(True, fi);
end;

initialization
  Randomize;
end.

