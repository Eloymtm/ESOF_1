import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/helper/globalVariables.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _capacidadeController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _consumoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  String? _combustivel;

  final _formKey = GlobalKey<FormState>();

  void _adicionarCarro() {
    if (_formKey.currentState!.validate()) {
      // Todos os campos estão preenchidos
      FirebaseFirestore.instance.collection('Car').add({
        'ano': int.parse(_anoController.text),
        'capacidade': int.parse(_capacidadeController.text),
        'combustivel': _combustivel,
        'cor': _corController.text,
        'km/100': double.parse(_consumoController.text),
        'marca': _marcaController.text,
        'matricula': _matriculaController.text,
        'modelo': _modeloController.text,
        'user': FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser?.uid),
      }).then((_) {
        _anoController.clear();
        _capacidadeController.clear();
        _combustivel = null;
        _corController.clear();
        _consumoController.clear();
        _marcaController.clear();
        _matriculaController.clear();
        _modeloController.clear();

        // Exibir mensagem de sucesso ou redirecionar para outra página
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Carro adicionado com sucesso')),
        );
      }).catchError((error) {
        // Exibir mensagem de erro se houver problemas ao adicionar o carro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar carro: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Carro',
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Marca', _marcaController),
              _buildTextField('Modelo', _modeloController),
              _buildTextField('Ano', _anoController, keyboardType: TextInputType.number),
              _buildTextField('Capacidade', _capacidadeController, keyboardType: TextInputType.number),
              _buildDropdownField('Combustível', ['Gasóleo', 'Gasolina', 'Elétrico']),
              _buildTextField('Cor', _corController),
              _buildTextField('Matrícula', _matriculaController),
              _buildTextField('Consumo (km/L)', _consumoController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarCarro,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                child: const Text('Adicionar Carro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        value: _combustivel,
        onChanged: (newValue) {
          setState(() {
            _combustivel = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
