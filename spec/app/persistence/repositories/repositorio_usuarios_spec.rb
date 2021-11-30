require 'spec_helper'

describe Persistence::Repositories::RepositorioUsuarios do
  let(:repositorio) { described_class.new }
  before(:each) do
    repositorio.delete_all
  end
  context 'Consulta de usuario' do
      it 'cuando se consulta por un usuario no registrado se devuelve vacío' do
        expect(repositorio.buscar_por_id_telegram('INVALIDO')).to be nil
      end

      it 'cuando se consulta por un usuario registrado se devuelven los datos correctos' do
        usuario = Usuario.new('Fulanito', 'fulanito@gmail.com', '123')
        usuario_guardado = repositorio.save(usuario)
        expect(usuario_guardado.nombre).to eq usuario.nombre
        expect(usuario_guardado.mail).to eq usuario.mail
        expect(usuario_guardado.id_telegram).to eq usuario.id_telegram
      end
  end
end
