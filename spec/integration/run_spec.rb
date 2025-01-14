# frozen_string_literal: true

RSpec.describe "bin/hanami", :app do
  def output
    Open3.capture3("bin/hanami #{args.join(' ')}", chdir: app.root)
  end

  let(:stdout) do
    output[1]
  end

  context "no args" do
    let(:args) { [] }

    it "prints out usage" do
      expect(stdout).to include("console")
      expect(stdout).to include("db [SUBCOMMAND]")
    end
  end

  context "db" do
    let(:args) { ["db"] }

    it "prints put db usage" do
      expect(stdout).to include("db create")
      expect(stdout).to include("db structure [SUBCOMMAND]")
    end
  end

  context "console" do
    context "irb" do
      let(:args) { ["console"] }

      xit "starts irb console" do
        expect(output[0]).to include("test[development]")
      end
    end

    context "defaulting to pry when it's present" do
      let(:args) { ["console"] }

      it "starts pry console" do
        expect(output[0]).to include("test[development]")
      end
    end

    context "pry" do
      let(:args) { ["console --repl pry"] }

      it "starts pry console" do
        expect(output[0]).to include("test[development]")
      end
    end

    context "forced env" do
      let(:args) { ["console --repl pry --env staging"] }

      it "starts pry console" do
        expect(output[0]).to include("test[staging]")
      end
    end
  end
end
