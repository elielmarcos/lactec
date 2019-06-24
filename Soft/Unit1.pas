unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, ShellApi;

type
  TFormIndex = class(TForm)
    StatusBarMenu: TStatusBar;
    ImageCollectionBlack: TImageCollection;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDQuerySQL: TFDQuery;
    PanelMenu: TPanel;
    SpeedButtonCadastrar: TSpeedButton;
    SpeedButtonBuscar: TSpeedButton;
    SpeedButtonExcluir: TSpeedButton;
    SpeedButtonSobre: TSpeedButton;
    SpeedButtonListar: TSpeedButton;
    PanelCadastrar: TPanel;
    LabelTituloCadastrar: TLabel;
    PanelBuscarExcluir: TPanel;
    LabelTituloBuscarExcluir: TLabel;
    SpeedButtonCadastrarVoltar: TSpeedButton;
    SpeedButtonSalvar: TSpeedButton;
    SpeedButtonNovo: TSpeedButton;
    SpeedButtonBuscarExcluirVoltar: TSpeedButton;
    LabelCadastrarID: TLabel;
    DataSourceCadastrar: TDataSource;
    LabelCadastrarTelefone: TLabel;
    LabelCadastrarIdade: TLabel;
    LabelCadastrarNome: TLabel;
    DBEditCadastrarNome: TDBEdit;
    DBEditCadastrarIdade: TDBEdit;
    DBEditCadastrarTelefone: TDBEdit;
    FDQuerySQLID: TIntegerField;
    FDQuerySQLTelefone: TStringField;
    FDQuerySQLIdade: TIntegerField;
    FDQuerySQLNome: TStringField;
    ComboBoxBuscar: TComboBox;
    EditBuscar: TEdit;
    SpeedButtonSair: TSpeedButton;
    PanelListar: TPanel;
    LabelTituloListar: TLabel;
    SpeedButtonListarVoltar: TSpeedButton;
    RadioGroupListar: TRadioGroup;
    DBGridListar: TDBGrid;
    SpeedButtonBuscarBuscar: TSpeedButton;
    DBGridBuscar: TDBGrid;
    SpeedButtonBuscarExcluir: TSpeedButton;
    PanelSobre: TPanel;
    LabelTituloSobre: TLabel;
    SpeedButtonSobreVoltar: TSpeedButton;
    MemoSobre: TMemo;
    ImageCollectionColor: TImageCollection;
    SpeedButtonFone: TSpeedButton;
    SpeedButtonGithub: TSpeedButton;
    SpeedButtonIcones: TSpeedButton;
    SpeedButtonEmail: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonListarClick(Sender: TObject);
    procedure SpeedButtonCadastrarClick(Sender: TObject);
    procedure SpeedButtonNovoClick(Sender: TObject);
    procedure SpeedButtonSalvarClick(Sender: TObject);
    procedure SpeedButtonCadastrarVoltarClick(Sender: TObject);
    procedure SpeedButtonBuscarClick(Sender: TObject);
    procedure SpeedButtonBuscarExcluirVoltarClick(Sender: TObject);
    procedure SpeedButtonSairClick(Sender: TObject);
    procedure SpeedButtonListarVoltarClick(Sender: TObject);
    procedure RadioGroupListarClick(Sender: TObject);
    procedure EditBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonBuscarBuscarClick(Sender: TObject);
    procedure SpeedButtonExcluirClick(Sender: TObject);
    procedure SpeedButtonBuscarExcluirClick(Sender: TObject);
    procedure SpeedButtonSobreClick(Sender: TObject);
    procedure SpeedButtonSobreVoltarClick(Sender: TObject);
    procedure SpeedButtonGithubClick(Sender: TObject);
    procedure SpeedButtonIconesClick(Sender: TObject);
    procedure SpeedButtonEmailClick(Sender: TObject);

  private
    { Private declarations }
    Procedure ShowHint(Sender: TObject);
    Procedure LoadIcons();
    Procedure IconPng(Btn: TSpeedButton; Ind: Integer; W: Integer; H: Integer);
  public
    { Public declarations }
  end;

var
  FormIndex: TFormIndex;
  TemaColor: Boolean;

implementation

{$R *.dfm}


// -----------------------------------------------
// Procedimento que verifica se foi pressionado ENTER
// -----------------------------------------------
procedure TFormIndex.EditBuscarKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then                       // Se for pressionado ENTER
  begin
    SpeedButtonBuscarBuscarClick(Self);   // Simular o click do botão Buscar
  end;

end;


// -----------------------------------------------
// Procedimento ao Finalizar o Formulário
// -----------------------------------------------
procedure TFormIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQuerySQL.Active := False;       // Desativa a tabela
  FDQuerySQL.Close;                 // Fecha tabela
  FDConnection.Close;               // Fecha a conexão com banco de dados
  Application.Terminate;            // Finaliza o app

end;


// -----------------------------------------------
// Procedimento ao Criar o Formulário
// -----------------------------------------------
procedure TFormIndex.FormCreate(Sender: TObject);
begin

  TemaColor := False;               // Tema dos ícones Preto

  FormIndex.ClientHeight := 382;    // Tamanho da janela do app
  FormIndex.ClientWidth := 310;     // Tamanho da janela do app

  Application.OnHint := ShowHint;   // Para habilitar os Hint's no StatusBar

  LoadIcons();                      // Carrega os ícones nos botões

  PanelMenu.Align := alClient;          // Expande menu no formulário
  PanelCadastrar.Align := alClient;     // Expande painel no formulário
  PanelBuscarExcluir.Align := alClient; // Expande painel no formulário
  PanelListar.Align := alClient;        // Expande painel no formulário
  PanelSobre.Align := alClient;         // Expande painel no formulário

  PanelCadastrar.Visible := False;      // Painel invisível
  PanelBuscarExcluir.Visible := False;  // Painel invisível
  PanelListar.Visible := False;         // Painel invisível
  PanelSobre.Visible := False;          // Painel invisível

  FDConnection.DriverName := 'SQLITE';  // Selecionar Drive SQLite para conexão
  FDConnection.Params.Database := ExtractFilePath(ParamStr(0)) + 'DB.db'; // Seleciona Base de Dados

  if not FileExists('DB.db') then       // Verifica se a Base de Dados existe
    ShowMessage('DataBase não encontrado. Será criado um novo arquivo .db');

  // Estabelece conexão e cria automáticamente a Base de Dados caso não exista
  try
    FDConnection.Open;
  except
    ShowMessage('Erro ao abrir conexão com banco de dados');
    StatusBarMenu.Panels[0].Text := 'ERRO';
  end;

  // Verifica se existe a tabela Cliente na Base de Dados
  try
    FDQuerySQL.Close;
    FDQuerySQL.SQL.Clear;
    FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
    FDQuerySQL.Prepare;
    FDQuerySQL.Open;
  except
    ShowMessage('Não foi encontrada a tabela Cliente. Será criado uma nova tabela');
    StatusBarMenu.Panels[0].Text := 'ERRO';
  end;

  // Cria nova tabela Cliente se não existir
  try
    FDQuerySQL.Close;
    FDQuerySQL.SQL.Clear;
    FDQuerySQL.SQL.Add('CREATE TABLE IF NOT EXISTS Cliente(');
    FDQuerySQL.SQL.Add('ID Integer PRIMARY KEY AUTOINCREMENT,');
    FDQuerySQL.SQL.Add('Telefone varchar(15),');
    FDQuerySQL.SQL.Add('Idade integer,');
    FDQuerySQL.SQL.Add('Nome varchar(100)');
    FDQuerySQL.SQL.Add(');');
    FDQuerySQL.Prepare;
    FDQuerySQL.ExecSQL;
  except
    ShowMessage('Erro ao criar nova tabela Cliente');
    StatusBarMenu.Panels[0].Text := 'ERRO';
  end;

  // Carregar tabela Cliente
  try
    FDQuerySQL.Close;
    FDQuerySQL.SQL.Clear;
    FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
    FDQuerySQL.Prepare;
    FDQuerySQL.Open;
  except
    ShowMessage('Erro ao abrir a tabela Cliente. O app será encerrado');
    Close;   // Finaliza o app se não foi possível carregar a tabela Cliente
  end;

  StatusBarMenu.Panels[0].Text := 'Conexão com DB - OK';

end;


// -----------------------------------------------
// Procedimento que associa os Hint's da aplicação no StatusBar
// -----------------------------------------------
Procedure TFormIndex.ShowHint(Sender: TObject);
begin

  StatusbarMenu.Panels[1].Text := GetLongHint (application.hint); // Para aparecer os Hint's no statusbar

end;


// -----------------------------------------------
// Procedimento clique do Botão Excluir no BuscarExcluir
// -----------------------------------------------
procedure TFormIndex.SpeedButtonBuscarExcluirClick(Sender: TObject);
begin

  try
  FDQuerySQL.Delete;    // Deleta o item selecionado e aborta se ocorrer erro
  except
    StatusBarMenu.Panels[0].Text := 'Exclui - ERRO';
    ShowMessage('Ocorreu algum erro durante a exclusão');
    Abort;
  end;

  StatusBarMenu.Panels[0].Text := 'Exclui - OK';
  ShowMessage('Cliente excluído com sucesso!');

  FDQuerySQL.Refresh;         // Refresh da tabela

  if FDQuerySQL.IsEmpty then  // Se a tabela ficar vazia, desabilita o botão BuscarExcluir
  begin
    SpeedButtonBuscarExcluir.Glyph := Nil;
    SpeedButtonBuscarExcluir.Enabled := False;
  end;

end;


// -----------------------------------------------
// Procedimento clique do Botão Voltar no BuscarExcluir
// -----------------------------------------------
procedure TFormIndex.SpeedButtonBuscarExcluirVoltarClick(Sender: TObject);
begin

  FDQuerySQL.Active := False;             // Desativa tabela
  PanelBuscarExcluir.Visible := False;    // Esconde Painel
  StatusBarMenu.Panels[0].Text := 'Menu';

end;


// -----------------------------------------------
// Procedimento clique do Botão Buscar no BuscarExcluir
// -----------------------------------------------
procedure TFormIndex.SpeedButtonBuscarBuscarClick(Sender: TObject);
begin

  if EditBuscar.Text = '' then   // Se nada foi digitado na busca, aborta
  begin
    StatusBarMenu.Panels[0].Text := 'Busca - ERRO';
    ShowMessage('Busca inválida, digite um dado válido');
    FDQuerySQL.Active := False;
    EditBuscar.SetFocus;
    Abort;
  end

  else                           // Realiza o busca por ID ou Nome do Cliente
  begin
    if ComboBoxBuscar.ItemIndex = 0 then   // Busca por ID
    begin
      FDQuerySQL.Close;
      FDQuerySQL.SQL.Clear;
      FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
      FDQuerySQL.SQL.Add('WHERE Cliente.ID = "'+EditBuscar.Text+'"');
      FDQuerySQL.Prepare;
      FDQuerySQL.Open;

      if FDQuerySQL.IsEmpty then  // Se a busca retornou vazia, volta para o menu
      begin
        ShowMessage('Cliente não encontrado');
        SpeedButtonBuscarExcluirVoltarClick(Self);
        Abort;
      end;


    end;
    if ComboBoxBuscar.ItemIndex = 1 then   // Busca por Nome
    begin
      FDQuerySQL.Close;
      FDQuerySQL.SQL.Clear;
      FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
      FDQuerySQL.SQL.Add('WHERE Cliente.Nome LIKE "%'+EditBuscar.Text+'%"');
      FDQuerySQL.Prepare;
      FDQuerySQL.Open;

      if FDQuerySQL.IsEmpty then  // Se a busca retornou vazia, volta para o menu
      begin
        ShowMessage('Cliente não encontrado');
        SpeedButtonBuscarExcluirVoltarClick(Self);
        Abort;
      end;

    end;
  end;

  // Caso tenha retornado resultado na busca
  StatusBarMenu.Panels[0].Text := 'Busca - OK';
  SpeedButtonBuscarExcluir.Enabled := True;         // Habilita botão Excluir
  IconPng(SpeedButtonBuscarExcluir,10,20,20);       // Carregar imagem no SpeedButton

end;


// -----------------------------------------------
// Procedimento Listar os clientes por ID ou Idade
// -----------------------------------------------
procedure TFormIndex.RadioGroupListarClick(Sender: TObject);
begin

  if (RadioGroupListar.ItemIndex = 0) then      // Se seleciona ID
  begin
    StatusBarMenu.Panels[0].Text := 'Ordenado por ID';
    FDQuerySQL.Close;
    FDQuerySQL.SQL.Clear;
    FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
    FDQuerySQL.SQL.Add('ORDER BY ID');
    DBGridListar.Columns[2].Visible := False;   // Coluna Idade
    DBGridListar.Columns[3].Visible := False;   // Coluna Telefone
    FDQuerySQL.Prepare;
    FDQuerySQL.Open;
  end;

  if (RadioGroupListar.ItemIndex = 1) then     // Se seleciona Idade
  begin
    StatusBarMenu.Panels[0].Text := 'Ordenado por Idade';
    FDQuerySQL.Close;
    FDQuerySQL.SQL.Clear;
    FDQuerySQL.SQL.Add('SELECT * FROM Cliente');
    FDQuerySQL.SQL.Add('ORDER BY Idade');
    DBGridListar.Columns[2].Visible := True;   // Coluna Idade
    DBGridListar.Columns[3].Visible := True;   // Coluna Telefone
    FDQuerySQL.Prepare;
    FDQuerySQL.Open;
  end;

end;


// -----------------------------------------------
// Procedimento clique do Botão Novo no Cadastrar
// -----------------------------------------------
procedure TFormIndex.SpeedButtonNovoClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Inserindo';
  SpeedButtonNovo.Visible := False;
  SpeedButtonSalvar.Visible := True;
  DBEditCadastrarNome.Enabled := True;
  DBEditCadastrarIdade.Enabled := True;
  DBEditCadastrarTelefone.Enabled := True;
  FDQuerySQL.Active := True;                   // Ativa tabela de clientes
  FDQuerySQL.Last;                             // Vai para última linha
  FDQuerySQL.Insert;                           // Insere novo cadastro na tabela
  LabelCadastrarID.Caption := 'ID: ---';       // ID ainda não confirmado
  DBEditCadastrarNome.SetFocus;

end;


// -----------------------------------------------
// Procedimento clique do Botão Salvar no Cadastrar
// -----------------------------------------------
procedure TFormIndex.SpeedButtonSalvarClick(Sender: TObject);
begin

  if DBEditCadastrarNome.Text = '' then        // Se o campo Nome é vazio, aborta
  begin
    ShowMessage('É necessário inserir o Nome do Cliente');
    DBEditCadastrarNome.SetFocus;
    Abort;
  end;

  if (DBEditCadastrarIdade.Text <> '') and     // Se o campo Idade não for vazio e menor que 0, aborta
     (StrToInt(DBEditCadastrarIdade.Text) <= 0) then
  begin
    ShowMessage('Idade inválida');
    DBEditCadastrarIdade.SetFocus;
    Abort;
  end;

  try
    try
      SpeedButtonNovo.Visible := True;
      SpeedButtonSalvar.Visible := False;
      DBEditCadastrarNome.Enabled := False;
      DBEditCadastrarIdade.Enabled := False;
      DBEditCadastrarTelefone.Enabled := False;
      FDQuerySQL.Post;                           // Confirmação inserção na tabela
      FDQuerySQL.Refresh;                        // Atualiza
      FDQuerySQL.Last;                           // Vai para última posição
      LabelCadastrarID.Caption := 'ID:  ' + FDQuerySQL.FieldByName('ID').AsString;  // Mostrar o ID
      finally
        StatusBarMenu.Panels[0].Text := 'Cadastro - OK';
        ShowMessage('Cliente cadastrado com sucesso!');
      end;
  except
    StatusBarMenu.Panels[0].Text := 'Cadastro - ERRO';
    ShowMessage('Ocorreu algum erro durante o cadastro');
  end;

end;


// -----------------------------------------------
// Procedimento clique do Botão Voltar no Cadastrar
// -----------------------------------------------
procedure TFormIndex.SpeedButtonCadastrarVoltarClick(Sender: TObject);
begin

  if FDQuerySQL.State = dsInsert then          // Se for clicado em voltar e está sendo inserido novo cliente
  begin                                        // Solicita, continuar inserção ou cancelar inserção

    if Application.MessageBox('Um Novo cadastro está sendo inserido. Deseja cancelar?'
                              ,'Atenção',mb_yesno + mb_iconquestion) = id_yes then
    begin
      FDQuerySQL.Cancel;                       // Se escolhido cancelar, Cancela inserção
      FDQuerySQL.Active := False;              // Desativa tabela
      PanelCadastrar.Visible := False;         // Esconde painel Cadastrar
      StatusBarMenu.Panels[0].Text := 'Menu';
    end;                                       // Caso contrário, não retorna ao menu e continua inserindo

  end
  else                                         // Se não estiver sendo inserido nenhum cliente
  begin
    FDQuerySQL.Active := False;                // Desativa tabela
    PanelCadastrar.Visible := False;           // Esconde painel Cadastrar
    StatusBarMenu.Panels[0].Text := 'Menu';
  end;

end;


// -----------------------------------------------
// Procedimento clique do Botão Voltar no Listar
// -----------------------------------------------
procedure TFormIndex.SpeedButtonListarVoltarClick(Sender: TObject);
begin

  FDQuerySQL.Active := False;
  PanelListar.Visible := False;                    // Esconde painel Listar
  StatusBarMenu.Panels[0].Text := 'Menu';

end;


// -----------------------------------------------
// Procedimento clique do Botão Voltar no Sobre
// -----------------------------------------------
procedure TFormIndex.SpeedButtonSobreVoltarClick(Sender: TObject);
begin

  PanelSobre.Visible := False;                     // Esconde painel Sobre
  StatusBarMenu.Panels[0].Text := 'Menu';

end;


// -----------------------------------------------
// Procedimento clique do Botão Cadastrar do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonCadastrarClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Cadastro';
  SpeedButtonNovo.Visible := True;
  SpeedButtonSalvar.Visible := False;
  DBEditCadastrarNome.Enabled := False;
  DBEditCadastrarIdade.Enabled := False;
  DBEditCadastrarTelefone.Enabled := False;
  FDQuerySQL.Active := False;
  LabelCadastrarID.Caption := 'ID:';
  PanelCadastrar.Visible := True;                  // Mostra Painel Cadastro

end;


// -----------------------------------------------
// Procedimento clique do Botão Buscar do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonBuscarClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Busca';
  ComboBoxBuscar.ItemIndex := 0;
  EditBuscar.Text := '';
  FDQuerySQL.Active := False;
  LabelTituloBuscarExcluir.Caption := 'Buscar Clientes';   // Configura para Buscar
  SpeedButtonBuscarExcluir.Visible := False;               // Configura para Buscar
  PanelBuscarExcluir.Hint := 'Buscar';             // Configura para Buscar
  PanelBuscarExcluir.Visible := True;              // Mostra Painel BuscarExcluir

end;


// -----------------------------------------------
// Procedimento clique do Botão Listar do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonListarClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Lista';
  FDQuerySQL.Active := False;
  PanelListar.Visible := True;
  DBGridListar.Columns[2].Visible := True;   // Coluna Idade
  DBGridListar.Columns[3].Visible := True;   // Coluna Telefone
  RadioGroupListar.ItemIndex := -1;          // Nenhuma opção de listar selecionado

end;


// -----------------------------------------------
// Procedimento clique do Botão Excluir do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonExcluirClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Exclui';
  ComboBoxBuscar.ItemIndex := 0;
  EditBuscar.Text := '';
  FDQuerySQL.Active := False;
  LabelTituloBuscarExcluir.Caption := 'Excluir Clientes';  // Configura para Excluir
  SpeedButtonBuscarExcluir.Visible := True;                // Configura para Excluir
  SpeedButtonBuscarExcluir.Enabled := False;               // Configura para Excluir
  SpeedButtonBuscarExcluir.Glyph := Nil;                   // Configura para Excluir
  PanelBuscarExcluir.Hint := 'Excluir';            // Configura para Excluir
  PanelBuscarExcluir.Visible := True;              // Mostra Painel BuscarExcluir

end;


// -----------------------------------------------
// Procedimento clique do Botão Sobre do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonSobreClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Sobre';
  PanelSobre.Visible := True;                      // Mostra Painel Sobre

end;


// -----------------------------------------------
// Procedimento clique do Botão Sair do Menu
// -----------------------------------------------
procedure TFormIndex.SpeedButtonSairClick(Sender: TObject);
begin

  Close;                                          // Finaliza aplicação

end;


// -----------------------------------------------
// Procedimento clique do Botão Email no Sobre
// -----------------------------------------------
procedure TFormIndex.SpeedButtonEmailClick(Sender: TObject);
begin
  // Abre o app padrão de e-mail
  StatusBarMenu.Panels[0].Text := 'Envia e-mail';
  ShellExecute(GetDesktopWindow,'open','mailto:elielmarcos@hotmail.com',nil,nil,sw_ShowNormal);

end;


// -----------------------------------------------
// Procedimento clique do Botão Github no Sobre
// -----------------------------------------------
procedure TFormIndex.SpeedButtonGithubClick(Sender: TObject);
begin
  // Abre o Browser padrão na página do github
  StatusBarMenu.Panels[0].Text := 'Acessa GitHub';
  ShellExecute(Handle,'open','http://github.com/elielmarcos',nil,nil,SW_SHOW);

end;


// -----------------------------------------------
// Procedimento clique do Botão Icones no Sobre
// -----------------------------------------------
procedure TFormIndex.SpeedButtonIconesClick(Sender: TObject);
begin

  StatusBarMenu.Panels[0].Text := 'Tema alterado';
  TemaColor := not TemaColor;               // Alterna o Tema
  LoadIcons();                              // Carrega os ícones nos botões

end;


// -----------------------------------------------
// Procedimento carregar imagem do ImageCollection
// -----------------------------------------------
Procedure TFormIndex.IconPng(Btn: TSpeedButton; Ind: Integer; W: Integer; H: Integer);
var
  bmp: TBitmap;                             // Variável bmp representar o objeto TBitmap
begin

  bmp:=TBitmap.Create;                      // Criamos o nosso objeto gráfico TBitmap

  try
    if TemaColor then                       // Se tema colorido carrega imagens do ImageCollectionColor
    begin
      bmp := ImageCollectionColor.GetBitmap(Ind, W, H); //As imagens utilizadas estão dentro de um ImageList
    end
    else                                    // Se tema preto carrega imagens do ImageCollectionBlack
    begin
      bmp := ImageCollectionBlack.GetBitmap(Ind, W, H); //As imagens utilizadas estão dentro de um ImageList
    end;

    Btn.Glyph:=bmp;                         // Associa imagem os botão que chamou o processo
  finally
    bmp.Free;                               // Libera objeto TBitmap
  end;

end;


// -----------------------------------------------
// Procedimento carregar as imagens do botões
// -----------------------------------------------
Procedure TFormIndex.LoadIcons();
begin

  // Botões do Menu
  IconPng(SpeedButtonCadastrar,0,32,32);  // Carregar imagem no SpeedButton
  IconPng(SpeedButtonBuscar,1,32,32);     // Carregar imagem no SpeedButton
  IconPng(SpeedButtonListar,2,32,32);     // Carregar imagem no SpeedButton
  IconPng(SpeedButtonExcluir,3,32,32);    // Carregar imagem no SpeedButton
  IconPng(SpeedButtonSobre,4,32,32);      // Carregar imagem no SpeedButton
  IconPng(SpeedButtonSair,5,32,32);       // Carregar imagem no SpeedButton

  // Botões do Cadastrar
  IconPng(SpeedButtonNovo,6,20,20);       // Carregar imagem no SpeedButton
  IconPng(SpeedButtonSalvar,7,20,20);     // Carregar imagem no SpeedButton
  IconPng(SpeedButtonCadastrarVoltar,8,20,20);      // Carregar imagem no SpeedButton

  // Botões do Buscar / Excluir
  IconPng(SpeedButtonBuscarBuscar,9,20,20);         // Carregar imagem no SpeedButton
  //IconPng(SpeedButtonBuscarExcluir,10,20,20);       // Carregar imagem no SpeedButton
  IconPng(SpeedButtonBuscarExcluirVoltar,8,20,20);  // Carregar imagem no SpeedButton

  // Botões do Listar
  IconPng(SpeedButtonListarVoltar,8,20,20);         // Carregar imagem no SpeedButton

  // Botões do Sobre
  IconPng(SpeedButtonSobreVoltar,8,20,20);          // Carregar imagem no SpeedButton
  IconPng(SpeedButtonFone,13,20,20);                // Carregar imagem no SpeedButton
  IconPng(SpeedButtonEmail,12,20,20);               // Carregar imagem no SpeedButton
  IconPng(SpeedButtonGithub,14,20,20);              // Carregar imagem no SpeedButton
  IconPng(SpeedButtonIcones,11,20,20);              // Carregar imagem no SpeedButton

end;

end.
