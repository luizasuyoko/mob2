package Controller;

import Model.Professor;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;

public class CursoController {
    //atributos
    private String nomeCurso;
    private Professor Professor;
    private List<Aluno> alunosList;
    //métodos
    //construtor
    public CursoController(String nomeCurso, Professor Professor) {
        this.nomeCurso = nomeCurso;
        this.Professor = Professor;
        this.alunosList = new ArrayList<>();
    }
    //adicionar alunos (create(crud))
    public void adicionarAluno(Aluno Aluno){
        alunosList.add(Aluno);
    }
    //exibirInformações (read(crud))
    public void exibirInformacoesCurso(){
        System.out.println("Nome Curso" +nomeCurso);
        System.out.println("Professor: " +Professor.getNome() );
        System.out.println("----");
        int contador = 0;
        for (Aluno Aluno : alunosList){
            contador++;
            System.out.println(contador+ ". " +Aluno.getNome() );
        }
        System.out.println("----");
    }
    //lançar nota
    //ver status
    
}
