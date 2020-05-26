unit UElem;

interface
uses Graphics, Types, SysUtils;
const
  BackColor=clWhite;
type
	TElem = class
	private
		FCanvas:TCanvas;
		FX,FY:integer; //точка привязки
		FColor:TColor;
    FSmallSize:Integer;
		FKey:integer;
    procedure SetColor(const Value: TColor);
    procedure Setx(const Value: integer); //Один эл-т соответствует числу из массива
	public
		constructor Create(ACanvas: TCanvas; ASmallSize:Integer; AX, AY: integer; AColor:TColor);
		destructor Destroy; override;
    procedure SetRandom;
    procedure Draw(IsVisible:boolean);
		procedure Show;
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

procedure TElem.Draw(IsVisible: boolean);
const
  cn = 18 ;
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
      Ellipse(Fx-FSmallSize,Fy-FSmallSize,Fx+FSmallSize, Fy+FSmallSize);
      SetLength(P,2*cn);
      da:=Pi/cn;
      a:=Pi/2;
      for i:=0 to cn-1 do
        begin
          p[2*i]:=Point(round(Fx+FSmallSize*cos(a)), round(Fy-FSmallSize*sin(a)));
          a:=a+da;
          p[2*i+1]:=Point(round(Fx+2*FSmallSize*cos(a)), round(Fy-2*FSmallSize*sin(a)));
          a:=a+da;
        end;
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
  Draw(False);
end;

procedure TElem.MoveBy(dx, dy: integer);
begin
  Hide;
  FX:=FX+dx;
  FY:=FY+dy;
  Show;
end;

procedure TElem.SetColor(const Value: TColor);
begin
  Hide;
  FColor:=Value;
  Show
end;

procedure TElem.SetRandom;
begin
  FKey:= Random(99)+1;
end;

procedure TElem.Setx(const Value: integer);
begin
  FX := Value;
end;

procedure TElem.Show;
begin
  Draw(True);
end;

initialization
  Randomize;
end.
