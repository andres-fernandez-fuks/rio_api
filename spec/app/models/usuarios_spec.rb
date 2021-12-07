require 'spec_helper'

describe Usuario do
  context 'Creacion de usuario' do
    it 'cuando se crea con todos sus campos validos' do
        usuario = described_class.new('Fulanito', 'fulanito@gmail.com', '14')
        expect(usuario.nombre).to eq 'Fulanito'
        expect(usuario.mail).to eq 'fulanito@gmail.com'
        expect(usuario.id_telegram).to eq '14'
    end

    it 'comparar dos usuarios iguales da verdadero' do
      usuario1 = described_class.new('Fulanito', 'fulanito@gmail.com', '14', 3030)
      usuario2 = described_class.new('Fulanito', 'fulanito@gmail.com', '14', 3030)
      expect(usuario1).to eq usuario2
    end

    it 'comparar dos usuarios diferentes da falso' do
      usuario1 = described_class.new('Fulanito', 'fulanito@gmail.com', '14', 3031)
      usuario2 = described_class.new('Fulanito', 'fulanito2@gmail.com', '14', 3030)
      expect(usuario1).to_not eq usuario2
    end
  end
end
