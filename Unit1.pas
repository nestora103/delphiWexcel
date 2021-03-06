unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComObj;

const
  xlCellTypeLastCell = $0000000B;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
//������� ��� �������� �����
  i: integer;
//������� ��� �������� ��������
  j: integer;
//���������� ������ �� ������ Excel
  PExelObj: variant;
//���������� ������ �� �����
  PExelBookCurrent: variant;
//��������� ������ �� �������� �����
  PExelBookActive: variant;
//���������� ������ �� �������� ����
  PExelSheetActive: variant;
//������������ ���������� ����� � ������� �� ����������� �����
  maxRow, maxCol: integer;
//��������� ���������� ��� ���������� ����������� ������ ����������
  currentStr: string;
  sss: string;
begin
//�������� ������ Excel.Application. ������ Excel.
  PExelObj := CreateOleObject('Excel.Application');
//������� ���� ���������� Excel ��������� ��� ���������� �������� ������
  PExelObj.Visible := false;
//������� Excel ���� ������� ����� ���������.
  if OpenDialog1.Execute then
    PExelObj.WorkBooks.Open(OpenDialog1.FileName);
  PExelBookCurrent := PExelObj.WorkBooks;
//�������� ������ � ��������� �������� �����. ������ � ��������.
  PExelBookCurrent.Item[PExelObj.WorkBooks.Count].Activate;
//��������� ������ �� �������� �����.
  PExelBookActive := PExelBookCurrent.Item[PExelObj.WorkBooks.Count];
//��������� ������ �� ������ ���� �������� �����
  PExelSheetActive := PExelBookActive.Sheets.Item[1];

//���������� ��������� ������ �� �������� �����.
  PExelSheetActive.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
//������������ ���������� ����� . ����� ActiveCell ������������� ������ � �������� Excel
  maxRow := PExelObj.ActiveCell.Row;
//������������ ���������� ��������
  maxCol := PExelObj.ActiveCell.Column;
//���������� ������ � ����������� ������
  PExelSheetActive.Cells[1, maxCol + 1] := '������ �'; {[i,j]}

//��������������� �������� ������� � �����������
  for i := 2 to maxRow do
  begin
    for j := 1 to maxCol do
    begin
      sss := '';

        //��������� 3,4,5,6,7 ������ � ������
      if ((PExelSheetActive.Cells[i, 3].Text = sss) and (PExelSheetActive.Cells[i, 4].Text = sss) and (PExelSheetActive.Cells[i, 5].Text = sss) and (PExelSheetActive.Cells[i, 6].Text = sss)) then
      begin
        currentStr := PExelSheetActive.Cells[i, 1];
      end
      else
      begin
        PExelSheetActive.Cells[i, maxCol + 1] := currentStr;
      end;
    end;
  end;

//���������� �������� ����� ��� ����� ������
  if SaveDialog1.Execute then
  begin
    //����� ���������
    PExelBookActive.SaveAs(form1.SaveDialog1.FileName + '.xlsx'{ExtractFileDir(ParamStr(0))+'/ReExcel.xlsx'});
    showMessage('�������������� ��������� �������!');
    //�������� �������� �����
    PExelBookActive.Close;
    //�������� ���������� Excel
    PExelObj.Application.Quit;
    PExelObj := Unassigned;
    halt;
  end
  else
  begin
    showMessage('�������������� ��������� �� �������!');
    //�������� �������� �����
    PExelBookActive.Close;
    halt;
  end;
end;

end.


