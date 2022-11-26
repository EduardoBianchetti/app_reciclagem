class Lixo {
  String? id;
  String? descricao;
  String? tipo;
  String? peso;

  Lixo() {
    id = null;
    descricao = "";
    tipo = "";
    peso = "";
  }

  Lixo.init(this.id, this.descricao, this.tipo, this.peso);
  factory Lixo.fromMap(Map<String, dynamic> json) {
    return Lixo.init(
        json['_id'], json['descricao'], json['tipo'], json['peso']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'descricao': descricao,
      'tipo': tipo,
      'peso': peso,
    };
  }

  @override
  toString() {
    return 'Lixo{descricao: $descricao, tipo: $tipo}';
  }

  bool operator ==(other) {
    return (other is Lixo && other.id == id);
  }
}
