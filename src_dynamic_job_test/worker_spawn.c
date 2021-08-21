#include <mpi.h>
#include <mpi-ext.h>
#include <stdio.h>
int main(int argc, char **argv) {
    int rank;
    MPI_Status status;

    MPI_Comm master_comm;
    char master_port[MPI_MAX_PORT_NAME] = "";
    char worker_port[MPI_MAX_PORT_NAME] = "";

    // 各コミュニケーターのルートランク
    const int self_root   = 0; // SELF   (MPI_COMM_SELF)
    const int master_root = 0; // MASTER (master_comm)
    const int worker_root = 0; // WORKER (MPI_COMM_WORLD)

    const int tag = 0;
    char message[100] = "";

    // 初期化処理
    MPI_Init(&argc, &argv);
    MPI_Comm_get_parent(&master_comm);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    printf("Hello! rank=%d\n", rank);

    if (rank == worker_root) {
        MPI_Open_port(MPI_INFO_NULL, worker_port);
        printf("worker_port=%s\n", worker_port); fflush(stdout);
    }

    if (rank == worker_root) {
        // マスタプロセスからのデータを受信する。
        MPI_Recv(master_port, MPI_MAX_PORT_NAME, MPI_CHAR, master_root, tag, master_comm, &status);
        printf("master_port=%s\n", master_port); fflush(stdout);
    }

    //  マスタプロセスとの通信を切断する。
    FJMPI_Mswk_disconnect(&master_comm);

    // マスタプロセスへポート名を送信する。
    if (rank == worker_root) {
        FJMPI_Mswk_connect(master_port, MPI_INFO_NULL, self_root, MPI_COMM_SELF, &master_comm);
        MPI_Send(worker_port, MPI_MAX_PORT_NAME, MPI_CHAR, master_root, tag, master_comm);
        FJMPI_Mswk_disconnect(&master_comm);
    }

    // マスタプロセスからのデータを受信する。
    if (rank == worker_root) {
        FJMPI_Mswk_accept(worker_port, MPI_INFO_NULL, self_root, MPI_COMM_SELF, &master_comm);
        MPI_Recv(message, MPI_MAX_PORT_NAME, MPI_CHAR, master_root, tag, master_comm, &status);
        printf("message=%s\n", message);
        FJMPI_Mswk_disconnect(&master_comm);
    }

    // 終了処理
    if (rank == worker_root) {
        MPI_Close_port(worker_port);
    }
    MPI_Finalize();
}
