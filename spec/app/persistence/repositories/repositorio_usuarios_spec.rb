require 'spec_helper'
require 'integration_helper'
describe Persistence::Repositories::RepositorioUsuarios do
  let(:repositorio) { described_class.new }
  before(:each) do
    repositorio.delete_all
  end
  context 'Consulta de usuario' do
      it 'cuando se consulta por id de telegram de un usuario no registrado se devuelve vacío' do
        expect(repositorio.buscar_por_id_telegram('INVALIDO')).to be nil
      end

      it 'cuando se consulta por id de telegram de un usuario registrado se devuelven los datos correctos' do
        usuario = Usuario.new('Fulanito', 'fulanito@gmail.com', '123')
        usuario_guardado = repositorio.save(usuario)
        usuario_consultado = repositorio.buscar_por_id_telegram('123')
        expect(usuario_consultado.nombre).to eq usuario.nombre
        expect(usuario_consultado.mail).to eq usuario.mail
        expect(usuario_consultado.id_telegram).to eq usuario.id_telegram
      end

      it 'cuando se consulta por mail de un usuario no registrado se devuelve vacío' do
        expect(repositorio.buscar_por_mail('INVALIDO')).to be nil
      end

      it 'cuando se consulta por mail de un usuario registrado se devuelven los datos correctos' do
        usuario = Usuario.new('Fulanito', 'fulanito@gmail.com', '123')
        usuario_guardado = repositorio.save(usuario)
        usuario_consultado = repositorio.buscar_por_mail('fulanito@gmail.com')
        expect(usuario_consultado.nombre).to eq usuario.nombre
        expect(usuario_consultado.mail).to eq usuario.mail
        expect(usuario_consultado.id_telegram).to eq usuario.id_telegram
      end
  end
end
